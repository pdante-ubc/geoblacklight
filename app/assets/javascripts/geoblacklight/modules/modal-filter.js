// Filter specific value in a facet modal

function filterList() {
    var input = document.getElementById('filterInput');
    var filter = input.value.toUpperCase();
    var ul = document.querySelectorAll('div.modal-body div.facet-extended-list .facet-values')[0];
    var li = ul.getElementsByTagName('li');
    // Loop through all list items, and hide those who don't match the search query
    for (var i = 0; i < li.length; i++) {
        var a = li[i].getElementsByTagName("a")[0];
        var txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}

$(document).on('keyup', '#filterInput', function(e) { filterList() });
