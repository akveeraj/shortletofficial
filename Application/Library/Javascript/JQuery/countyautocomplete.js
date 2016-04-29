/*jslint  browser: true, white: true, plusplus: true */
/*global $j, countries */

$j(function () {
    'use strict';

    var countriesArray = $j.map(counties, function (value, key) { return { value: value, data: key }; });

    // Setup jQuery ajax mock: 
    $j.mockjax({
        url: '*',
        responseTime: 2000,
        response: function (settings) {
            var query = settings.data.query,
                queryLowerCase = query.toLowerCase(), 
                re = new RegExp('\\b' + $j.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi'),
                suggestions = $j.grep(countriesArray, function (country) {
                     // return country.value.toLowerCase().indexOf(queryLowerCase) === 0;
                    return re.test(country.value);
                }),
                response = {
                    query: query,
                    suggestions: suggestions
                };

            this.responseText = JSON.stringify(response);
        }
    });

    // Initialize ajax autocomplete:
    $j('#jobregion').autocomplete({
        // serviceUrl: '/autosuggest/service/url',
        lookup: countriesArray,
        lookupFilter: function(suggestion, originalQuery, queryLowerCase) {
            var re = new RegExp('\\b' + $j.Autocomplete.utils.escapeRegExChars(queryLowerCase), 'gi');
            return re.test(suggestion.value);
        }
    });
	
});