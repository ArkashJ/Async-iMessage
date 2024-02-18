import { runAppleScript } from "run-applescript";
import * as customScript from "./custom.applescript";

export default async function Command() {
  await runAppleScript(customScript.default);
}
