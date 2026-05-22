function fzy_tab_toggle
    if test "$FZY_TAB_ENABLE" = 1
        fzy_tab_disable
    else
        fzy_tab_enable
    end
end
