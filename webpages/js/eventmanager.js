var $oEventsTable, $oCurrTable, $oCurrPairTable;
var $sEventsAddRowForm, $sCurrenciesAddRowForm, $sCurrencyPairsAddRowForm, $sCurrSelect;

$(document).ready(function() {
  bindFXEventsControls();
  getEvents();
  getCurrencies();
  getCurrencyPairs();
  getCurrencySelect();
  getEventsAddFormRow();
  getCurrenciesAddFormRow();
  getCurrencyPairsAddFormRow();
});

/**
 * function: getEvents()
 * Load event list html block from server
 */
function getEvents() {
  $.post("request.aspx", { a: "getEvents" }, function(response) {
    $("#eventlist").html("").append(response);
    $oEventsTable = $("#eventlistTable").dataTable();
  });
}

/**
* function: getEventAddFormRow()
* Load currency pair list html select block from server
*/
function getEventsAddFormRow() {
  $.post("request.aspx", { a: "getEventsAddFormRow" }, function(response) {
    $sEventsAddRowForm = response.replace(/<\?xml(?:.|\s)*?>/g, "").replace(/\"/g, "'");
  });
}

/**
 * function: addEvent()
 * Add new event row to database
 */
function addEvent(obj) {
  var curr = $('#eventlistTable #curr').val();
  var eventid = $('#eventlistTable #eventid').val();
  var eventname = $('#eventlistTable #name').val();
  var next_date = $('#eventlistTable #next_date').val();
  var recurring = $('#eventlistTable #recurring').val();
  var previous = $('#eventlistTable #previous').val();
  var importance = $('#eventlistTable #importance').val();
  var watch = $('#eventlistTable #watch').val();
  $.prompt('Click OK to confirm adding forex event ' + eventid + ' (' + eventname + ').', { buttons: { Ok: true, Cancel: false },
    callback: function(v, m, f) {
      if (v) {
        $.post("request.aspx", { "a": "addEvent", "curr": curr, "eventid": eventid, "name": eventname, "next_date": next_date, "recurring": recurring, "previous": previous, "importance": importance, "watch": watch }, function(response) {
          // Server response
          $.prompt(response);
          // Refresh table
          getEvents();
          // Enable add control, hide save control
          $("#saveEventNew").hide('fast');
          $("#cancelEventNew").hide('fast');
          $("#addEventsTableRow").show('slow');
        });
      }
    }
  });
}

/**
 * function: fnClickAddEventRow()
 * Adds row to the Eventss HTML table.
 */
function fnClickAddEventsRow() {
  // Append it to the Events table.
  //$oEventsTable.fnAddData($aEventRowElements);
  $('#eventlistTable tbody tr:first').before($sEventsAddRowForm);
  $('#eventlistTable #curr').parent().html("").append($sCurrSelect);
  // Bind date control to next_date input field
  $(function() {
    $("#next_date").datepicker();
  });
  // Focus on the first form element.
  $('#eventlistTable #eventid').focus();
  // Enable save control, hide add control
  $("#addEventsTableRow").hide('fast');
  $("#saveEventNew").show('slow');
  $("#cancelEventNew").show('slow');
}

/**
* function: fnClickDelEventsRow()
* Adds row to the Events HTML table.
*/
function fnClickDelEventsRow() {
  // Remove first row in currency pair table
  $('#eventlistTable tbody tr:first').remove();
  // Enable add control, hide save control
  $("#saveEventNew").hide('fast');
  $("#cancelEventNew").hide('fast');
  $("#addEventsTableRow").show('slow');
}
 
/**
* function: getCurrencies()
* Load currency list html block from server
*/
function getCurrencies() {
  $.post("request.aspx", { a: "getCurrencies" }, function(response) {
    $("#currencylist").html("").append(response);
    $oCurrTable = $("#currencylistTable").dataTable();
  });
}
/**
* function: getCurrencyAddFormRow()
* Load currency html form elements table row from server
*/
function getCurrenciesAddFormRow() {
  $.post("request.aspx", { a: "getCurrenciesAddFormRow" }, function(response) {
    $sCurrenciesAddRowForm = response.replace(/<\?xml(?:.|\s)*?>/g, "");
  });
}

/**
* function: getCurrencySelect()
* Load currency pair list html select block from server
*/
function getCurrencySelect() {
  $.post("request.aspx", { a: "getCurrencySelect" }, function(response) {
    //$aEventRowElements[0] = response.replace(/<\?xml(?:.|\s)*?>/g, "").replace(/\"/g, "'");
    $sCurrSelect = response.replace(/<\?xml(?:.|\s)*?>/g, "");
  });
}

/**
* function: addCurrency()
* Add new currency row to database
*/
function addCurrency(obj) {
  var curr = $('#currencylistTable #curr').val();
  var name = $('#currencylistTable #name').val();
  $.prompt('Click OK to confirm adding currency ' + curr + ' (' + name + ').', { buttons: { Ok: true, Cancel: false },
    callback: function(v, m, f) {
      if (v) { 
        $.post("request.aspx", { "a":"addCurrency", "curr":curr, "name":name }, function(response) {
          // Server response
          $.prompt(response);
          // Refresh table
          getCurrencies();
          // Refresh select field
          getCurrencySelect();
          // Enable add control, hide save control
          $("#saveCurrencyNew").hide('fast');
          $("#cancelCurrencyNew").hide('fast');
          $("#addCurrenciesTableRow").show('slow');
        });
      }
    } 
  });
}

/**
* function: fnClickAddCurrencyRow()
* Adds row to the Currencies HTML table.
*/
function fnClickAddCurrenciesRow() {
  // Append it to the Currency table.
  $('#currencylistTable tbody tr:first').before($sCurrenciesAddRowForm);
  // Focus on the first form element.
  $('#currencylistTable #curr').focus();
  // Enable save control, hide add control
  $("#addCurrenciesTableRow").hide('fast');
  $("#saveCurrencyNew").show('slow');
  $("#cancelCurrencyNew").show('slow');
}

/**
* function: fnClickDelCurrenciesRow()
* Adds row to the Currency HTML table.
*/
function fnClickDelCurrenciesRow() {
  // Remove first row in currency table
  $('#currencylistTable tbody tr:first').remove();
  // Enable add control, hide save control
  $("#saveCurrencyNew").hide('fast');
  $("#cancelCurrencyNew").hide('fast');
  $("#addCurrenciesTableRow").show('slow');
}

/**
* function: getCurrencypairs()
* Load currency pair list html block from server
*/
function getCurrencyPairs() {
  $.post("request.aspx", { a: "getCurrencyPairs" }, function(response) {
    $("#currencypairlist").html("").append(response);
    $oCurrPairTable = $("#currencypairlistTable").dataTable();
  });
}

/**
* function: getCurrencyPairAddFormRow()
* Load currency html form elements table row from server
*/
function getCurrencyPairsAddFormRow() {
  $.post("request.aspx", { a: "getCurrencyPairsAddFormRow" }, function(response) {
    $sCurrencyPairsAddRowForm = response.replace(/<\?xml(?:.|\s)*?>/g, "");
  });
}

/**
* function: addCurrencyPair()
* Add new event row to database
*/
function addCurrencyPair(obj) {
  var base = $('#currencypairlistTable #base').val();
  var quote = $('#currencypairlistTable #quote').val();
  $.prompt('Click OK to confirm adding currency pair ' + base + '/' + quote + '.', { buttons: { Ok: true, Cancel: false },
    callback: function(v, m, f) {
      if (v) {
        $.post("request.aspx", { "a":"addCurrencyPair", "base":base, "quote":quote }, function(response) {
          // Server response
          $.prompt(response);
          // Refresh table
          getCurrencyPairs();
          // Enable add control, hide save control
          $("#saveCurrencyPairNew").hide('fast');
          $("#cancelCurrencyPairNew").hide('fast');
          $("#addCurrencyPairsTableRow").show('slow');
        });
      }
    }
  });
}

/**
* function: fnClickAddCurrencyPairsRow()
* Adds row to the Currency Pairs HTML table.
*/
function fnClickAddCurrencyPairsRow() {
  // Append it to the Currency Pairs table.
  $('#currencypairlistTable tbody tr:first').before($sCurrencyPairsAddRowForm);
  // Replace base input with select
  $('#currencypairlistTable #base').replaceWith($sCurrSelect);
  // Set base input id attr
  $('#currencypairlistTable #curr').attr("id", "base");
  // Replace quote input with select
  $('#currencypairlistTable #quote').replaceWith($sCurrSelect);
  // Set quote input id attr
  $('#currencypairlistTable #curr').attr("id", "quote");
  // Enable save control, hide add control
  $("#addCurrencyPairsTableRow").hide('fast');
  $("#saveCurrencyPairNew").show('slow');
  $("#cancelCurrencyPairNew").show('slow');
}

/**
* function: fnClickDelCurrencyPairsRow()
* Adds row to the Currency Pairs HTML table.
*/
function fnClickDelCurrencyPairsRow() {
  // Remove first row in currency pair table
  $('#currencypairlistTable tbody tr:first').remove();
  // Enable add control, hide save control
  $("#saveCurrencyPairNew").hide('fast');
  $("#cancelCurrencyPairNew").hide('fast');
  $("#addCurrencyPairsTableRow").show('slow');
}

/**
* function: bindFXEventsControls()
* Runs on page load to bind javascript functions to HTML controls.
*/
function bindFXEventsControls() {
  // Control to get events
  $("#getEvents").live("click", function() {
    getEvents();
    return false;
  });

  // Control to add event
  $("#saveEventNew").live("click", function() {
    addEvent(this);
    return false;
  });

  // Control to cancel new currency
  $("#cancelEventNew").live("click", function() {
    fnClickDelEventsRow(this);
    return false;
  });

  // Control to add FXEvent table row
  $("#addEventsTableRow").live("click", function() {
    fnClickAddEventsRow();
    return false;
  });

  // Control to get currencies
  $("#getCurrencies").live("click", function() {
    getCurrencies();
    return false;
  });

  // Control to add currency
  $("#saveCurrencyNew").live("click", function() {
    addCurrency(this);
    return false;
  });

  // Control to cancel new currency
  $("#cancelCurrencyNew").live("click", function() {
    fnClickDelCurrenciesRow(this);
    return false;
  });

  // Control to add Currency table row
  $("#addCurrenciesTableRow").live("click", function() {
    fnClickAddCurrenciesRow();
    return false;
  });

  // Control to get currencies
  $("#getCurrencyPairs").live("click", function() {
    getCurrencyPairs();
    return false;
  });

  // Control to add currency pair
  $("#saveCurrencyPairNew").live("click", function() {
    addCurrencyPair(this);
    return false;
  });

  // Control to cancel new currency
  $("#cancelCurrencyPairNew").live("click", function() {
    fnClickDelCurrencyPairsRow(this);
    return false;
  });

  // Control to add Currency table row
  $("#addCurrencyPairsTableRow").live("click", function() {
    fnClickAddCurrencyPairsRow();
    return false;
  });

  // toggles the Events list on clicking the noted link  
  $('div#events h3').live("click", function() {
    $('#eventlist').slideToggle(800);
    return false;
  });

  // toggles the slickbox on clicking the noted link  
  $('div#currencies h3').live("click", function() {
    $('#currencylist').slideToggle();
    return false;
  });  

  // toggles the slickbox on clicking the noted link  
  $('div#currencypairs h3').live("click", function() {
    $('#currencypairlist').slideToggle();
    return false;
  });  
}