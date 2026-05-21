{ ... }:
# Editors
{
  # Post-modern editing:
  # https://helix-editor.com/
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_frappe";
      editor = {
        true-color = true;
        undercurl = true;
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        color-modes = true;
        indent-guides = {
          character = "╎";
          render = true;
        };
        # Disable gutters to save space on mobile
        gutters = [ ];
        # Minimum severity to show a diagnostic after the end of a line
        end-of-line-diagnostics = "hint";
        inline-diagnostics = {
          # Show inline diagnostics when the cursor is on the line
          cursor-line = "error";
          # Don't expand diagnostics unless the cursor is on the line
          other-lines = "disable";
        };
      };
    };
  };
}
