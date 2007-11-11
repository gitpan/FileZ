//
// omfg v1
//
function display (content_element, image_element) {

    if ($(image_element).src.match('show')) {
        var src = $(image_element).src.replace(/show/, "hide");
        $(image_element).src = src;
    }
    else {
        var src = $(image_element).src.replace(/hide/, "show");
        $(image_element).src = src;
    }
    
    if (Element.visible(content_element)) {
        Element.toggle(content_element);
        return 1;
    }
    else {
        Element.toggle(content_element);
        return 0;
    }
}
