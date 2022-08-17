$(document).ready(function () {
  var bloodhound = new Bloodhound({
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.value);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    limit: 10,
    remote: { url: "/users/search/%QUERY", wildcard: "%QUERY" },
  });
  bloodhound.initialize();

  $("#typeahead").typeahead(null, {
    name: "name",
    displayKey: "username",
    source: bloodhound.ttAdapter(),
  });

  $("#typeahead").bind("typeahead:selected", function (event, datum, name) {
    window.location.href = "/profile/" + datum.username;
  });
});
