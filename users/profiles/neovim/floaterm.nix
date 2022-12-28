{
  programs.nixvim = {
    maps = {
      normalVisualOp."<c-t>" = {
        silent = true;
        action = "<cmd>FloatermToggle<cr>";
        description = "Floaterm";
      };
      terminal."<c-t>" = {
        silent = true;
        action = "<cmd>FloatermToggle<cr>";
        description = "Floaterm";
      };
    };

    plugins = {
      floaterm = {
        enable = true;
        autoInsert = true;
        opener = "edit";
      };
    };
  };
}
