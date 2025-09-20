{ ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "GruvboxDark";
      mouse-hide-while-typing = true;
      keybind = [
        "alt+h=goto_split:left"
        "alt+l=goto_split:right"
        "alt+j=goto_split:down"
        "alt+k=goto_split:up"

        "ctrl+b>h=new_split:left"
        "ctrl+b>l=new_split:right"
        "ctrl+b>j=new_split:down"
        "ctrl+b>k=new_split:up"
        "ctrl+b>z=toggle_split_zoom"

        "ctrl+b>c=new_tab"
        "ctrl+b>x=close_tab"
        "ctrl+b>n=next_tab"
        "ctrl+b>p=previous_tab"
        "ctrl+b>0=goto_tab:1"
        "ctrl+b>1=goto_tab:2"
        "ctrl+b>2=goto_tab:3"
        "ctrl+b>3=goto_tab:4"
        "ctrl+b>4=goto_tab:5"
        "ctrl+b>5=goto_tab:6"
        "ctrl+b>6=goto_tab:7"
        "ctrl+b>7=goto_tab:8"

        "ctrl+b>r=reload_config"
      ];
    };
  };
}
