EL = {
        setup: function() {
            //$("#sortby_name").click(function() {EL.sortTable("name")}).removeAttr('href');
            $("#header_name").append($('<select>', {id: 'name_search_start',
                                                    width: 110})
                                        .append(new Option("Starts with", true))
                                        .append(new Option("Contains", false)));
            $("#header_name").append($('<input>', {id: 'search_name',
                                                    type: 'text',
                                                    width: 150}));

            EL.activate_search("name", "search_name", "name_search_start");
            $("#header_item_type").append($('<div>', {id: 'type_list', text: "(insert list of types here)"}))
            
            $("#sortby_name").toggle(
                    function() {EL.sortTable(true, "name")},
                    function() {EL.sortTable(false, "name")}
                    ).removeAttr('href');
            $("#sortby_item_type").toggle(
                    function() {EL.sortTable(true, "item_type")},
                    function(){EL.sortTable(false, "item_type")}
                    ).removeAttr('href');
        },
        //credit: stack overflow post: http://stackoverflow.com/questions/4619375/jquery-live-search
        activate_search: function(field, input_id, check_start) {
            $("#"+input_id).keyup(function(e) {
                EL.search(e, field, input_id, check_start);
            }).bind("paste", function(e) {
                // have to do this so the DOM can catch up on mouse right-click paste
                setTimeout(function() { EL.search(e, field, input_id, check_start); }, 100);
            });
        },
        search: function(event, field, input_id, check_start) {
            var input = $("#"+input_id).val()
            if (input == "") {
                EL.showAll();
            }
            else {
                var starts = $("#"+check_start).val();
                var loc;
                if (starts === 'true') {
                    loc = "^\\s+";
                } else {
                    loc = ".*";
                }
                var search_regex = new RegExp(loc + input, 'i');
                $("table tbody tr").each(function() {
                    if (search_regex.test($(this).find("#"+field).text())) {
                        $(this).show();
                    }
                    else {
                        $(this).hide();
                    }
                })
//                    + field + "[" + loc + "=\"" + input.replace(/\s+/g, '_')+"\"]").show();
            }
        },
        showAll: function() {
            $("table tbody tr").show()
        },
        hideAll: function() {
            $("table tbody tr").hide();
        },
        sortTable: function(ascending, sortField) {
            EL.sortTableWithComparator(ascending ? EL.compareAsc : EL.compareDesc,
                                    sortField);
        },
        sortTableWithComparator: function(comparator, sortField) {
            //use plugin: sortElements
            $("table tr td#"+sortField).sortElements(comparator, function() {
                return this.parentNode;
            });
        },
        compareAsc: function(a, b) {
                return $(a).text() > $(b).text() ? 1 : -1;
        },
        compareDesc: function(a, b) {
                return - EL.compareAsc(a, b);
                //return $(a).text() < $(b).text() ? 1 : -1;
        }
    };
