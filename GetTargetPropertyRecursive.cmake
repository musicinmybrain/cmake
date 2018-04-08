
function(get_target_property_recursive outputvar target property)
    get_target_property(_rec_target_type ${target} TYPE)
    set(_ept_prop_ll LINK_LIBRARIES)
    if(_rec_target_type STREQUAL "INTERFACE_LIBRARY")
        set(_ept_prop_ll INTERFACE_LINK_LIBRARIES)
        if(property STREQUAL "INCLUDE_DIRECTORIES")
            set(property INTERFACE_INCLUDE_DIRECTORIES)
        elseif(property STREQUAL "LINK_LIBRARIES")
            set(property INTERFACE_LINK_LIBRARIES)
        endif()
    endif()
    get_target_property(_ept_li ${target} ${property})
    get_target_property(_ept_deps ${target} ${_ept_prop_ll})
    foreach(_ept_ll ${_ept_deps})
        if(TARGET ${_ept_ll})
            get_target_property_recursive(_ept_out ${_ept_ll} ${property})
            list(APPEND _ept_li ${_ept_out})
        endif()
    endforeach()
    set(${outputvar} ${_ept_li} PARENT_SCOPE)
endfunction()
