// Repo-local guardrail for nixfiles.
// Auto-discovered by opencode from .opencode/plugin/ — no config entry needed.
// Intercepts `git commit` and refuses it until the repo's checks pass.

const FLAKE_CHECK_TIMEOUT_MS = 15 * 60 * 1000;

// A `git commit` at the start of the command or after a shell separator.
const COMMIT_RE = /(?:^|[;&|(\n]\s*)git(?:\s+-{1,2}[A-Za-z-]+)*\s+commit(?:\s|$)/;

const isShellScript = (file) => file.endsWith(".sh") || file.endsWith("zsh_functions");

const bytes = (buf) => (buf ? Buffer.from(buf).toString("utf8").trim() : "");

export default async ({ $, directory }) => {
  const shell = directory ? $.cwd(directory) : $;

  const quote = (parts) => parts.map((p) => shell.escape(String(p))).join(" ");
  const exec = (parts) => shell`${{ raw: quote(parts) }}`.nothrow().quiet();

  async function run(parts, { timeoutMs = 0, label } = {}) {
    const name = label ?? parts[0];
    let cmd = parts;
    if (timeoutMs) {
      const probe = await exec(["which", "timeout"]);
      if (probe.exitCode === 0) cmd = ["timeout", String(Math.ceil(timeoutMs / 1000)), ...parts];
    }
    const result = timeoutMs
      ? await Promise.race([
          exec(cmd),
          new Promise((_, reject) =>
            setTimeout(
              () => reject(new Error(`guardrails: ${name} exceeded ${timeoutMs / 1000}s; commit blocked.`)),
              timeoutMs,
            ),
          ),
        ])
      : await exec(cmd);
    if (result.exitCode !== 0) {
      const detail = [bytes(result.stderr), bytes(result.stdout)].filter(Boolean).join("\n");
      throw new Error(
        `guardrails: ${name} failed (exit ${result.exitCode}); commit blocked.${detail ? `\n\n${detail}` : ""}`,
      );
    }
  }

  return {
    "tool.execute.before": async ({ tool }, { args }) => {
      if (tool !== "bash") return;
      const command = typeof args?.command === "string" ? args.command : "";
      if (!COMMIT_RE.test(command)) return;

      const staged = (await shell`git diff --cached --name-only --diff-filter=ACMR`.quiet().text())
        .split("\n")
        .map((line) => line.trim())
        .filter(Boolean);

      const nixFiles = staged.filter((file) => file.endsWith(".nix"));
      const shellFiles = staged.filter(isShellScript);

      if (nixFiles.length) await run(["nixfmt", "--check", ...nixFiles], { label: "nixfmt --check" });
      if (shellFiles.length) await run(["shellcheck", ...shellFiles], { label: "shellcheck" });
      if (nixFiles.length) {
        await run(["nix", "flake", "check"], { timeoutMs: FLAKE_CHECK_TIMEOUT_MS, label: "nix flake check" });
      }
    },
  };
};