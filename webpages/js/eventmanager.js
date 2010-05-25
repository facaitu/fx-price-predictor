var $oFXEventsTable, $oFXEventAliasesTable, $oCurrTable, $oCurrPairTable;
var $sFXEventsAddRowForm, $sFXEventAliasesAddRowForm, $sCurrenciesAddRowForm, $sCurrencyPairsAddRowForm, $sCurrSelect;

$(document).ready(function() {
  bindFXEventsControls();

  getFXEvents();
  getFXEventAliases();
  getCurrencies();
  getCurrencyPairs();
  getCurrencySelect();
  getFXEventsAddFormRow();
  getFXEventAliasesAddFormRow();
  getCurrenciesAddFormRow();
  getCurrencyPairsAddFormRow();
});

/**
 * function: getFXEvents()
 * Load event list html block from server
 */
function getFXEvents() {
  $.post("request.aspx", { a: "getFXEvents" }, function(response) {
    $("#fxeventlist").html("").append(response);
    $oFXEventsTable = $("#fxeventlistTable").dataTable();
  });
}

/**
* function: getFXEventAddFormRow()
* Load currency pair list html select block from server
*/
function getFXEventsAddFormRow() {
  $.post("request.aspx", { a: "getFXEventsAddFormRow" }, function(response) {
    $sFXEventsAddRowForm = response.replace(/<\?xml(?:.|\s)*?>/g, "").replace(/\"/g, "'");
  });
}

/**
* function: delFXEvents()
* Delete selected events from server
*/
function delFXEvents(v, m, f) {
  var aEvtids = [];
  if (v) { // If we clicked OK...
    // Build the list of checked checkboxes into a string that will be passed to the web service.
    $("#fxeventlist input[type=checkbox]:checked").each(
      function(index) {
        aEvtids.push($(this).val());
      }
    );
    // Send those events to Hell.
    $.post("request.aspx", { a: "delFXEvents", "evtids": aEvtids.join() }, function(response) {
      $.prompt(response);
      getFXEvents();
    });
  }
}

/**
 * function: delFXEvents_Verify()
 * Verify deletions before sending request to server.
 */
function delFXEvents_Verify() {
  $.prompt("Do you really want to delete these events? This action is permanent.", {
  submit: delFXEvents,
  buttons: { Ok: true, Cancel: false }
  });
}

/**
* function: addFXEvent()
* Add new event row to database
*/
function addFXEvent(obj) {
  var curr = $('#fxeventlistTable #curr').val();
  var eventid = $('#fxeventlistTable #eventid').val();
  var eventname = $('#fxeventlistTable #name').val();
  var next_date = $('#fxeventlistTable #next_date').val();
  var recurring = $('#fxeventlistTable #recurring').val();
  var previous = $('#fxeventlistTable #previous').val();
  var importance = $('#fxeventlistTable #importance').val();
  var watch = $('#fxeventlistTable #watch').val();
  $.prompt('Click OK to confirm adding forex event ' + eventid + ' (' + eventname + ').', { buttons: { Ok: true, Cancel: false },
    callback: function(v, m, f) {
      if (v) {
        $.post("request.aspx", { "a": "addFXEvent", "curr": curr, "eventid": eventid, "name": eventname, "next_date": next_date, "recurring": recurring, "previous": previous, "importance": importance, "watch": watch }, function(response) {
          // Server response
          $.prompt(response);
          // Refresh table
          getFXEvents();
          // Enable add control, hide save control
          $("#saveFXEventNew").hide('fast');
          $("#cancelFXEventNew").hide('fast');
          $("#addFXEventsTableRow").show('slow');
        });
      }
    }
  });
}

/**
 * function: fnClickAddFXEventRow()
 * Adds row to the Eventss HTML table.
 */
function fnClickAddFXEventsRow() {
  // Append it to the Events table.
  //$oEventsTable.fnAddData($aEventRowElements);
  $('#fxeventlistTable tbody tr:first').before($sFXEventsAddRowForm);
  $('#fxeventlistTable #curr').parent().html("").append($sCurrSelect);
  // Bind date control to next_date input field
  $(function() {
    $("#next_date").datepicker();
  });
  // Focus on the first form element.
  $('#fxeventlistTable #eventid').focus();
  // Enable save control, hide add control
  $("#addFXEventsTableRow").hide('fast');
  $("#saveFXEventNew").show('slow');
  $("#cancelFXEventNew").show('slow');
}

/**
* function: fnClickDelFXEventsRow()
* Adds row to the Events HTML table.
*/
function fnClickDelFXEventsRow() {
  // Remove first row in currency pair table
  $('#fxeventlistTable tbody tr:first').remove();
  // Enable add control, hide save control
  $("#saveFXEventNew").hide('fast');
  $("#cancelFXEventNew").hide('fast');
  $("#addFXEventsTableRow").show('slow');
}

/**
* function: getFXEventAliases()
* Load event alias list html block from server
*/
function getFXEventAliases() {
  $.post("request.aspx", { a: "getFXEventAliases" }, function(response) {
    $("#fxeventaliaslist").html("").append(response);
    $oFXEventAliasesTable = $("#fxeventaliaslistTable").dataTable();
  });
}

/**
* function: getFXEventAliasesAddFormRow()
* Load event alias list html select block from server
*/
function getFXEventAliasesAddFormRow() {
  $.post("request.aspx", { a: "getFXEventAliasesAddFormRow" }, function(response) {
    $sFXEventAliasesAddRowForm = response.replace(/<\?xml(?:.|\s)*?>/g, "").replace(/\"/g, "'");
  });
}

/**
* function: delFXEventAliases()
* Delete selected event aliases from server
*/
function delFXEventAliases(v, m, f) {
  var aEvtids = [];
  if (v) { // If we clicked OK...
    // Build the list of checked checkboxes into a string that will be passed to the web service.
    $("#fxeventaliaslist input[type=checkbox]:checked").each(
      function(index) {
        aEvtids.push($(this).val());
      }
    );
    // Send those events to Hell.
    $.post("request.aspx", { a: "delFXEventAliases", "evtids": aEvtids.join() }, function(response) {
      $.prompt(response);
      getFXEventAliases();
    });
  }
}

/**
* function: delFXEventAliases_Verify()
* Verify deletions before sending request to server.
*/
function delFXEventAliases_Verify() {
  $.prompt("Do you really want to delete these event aliases? This action is permanent.", {
    submit: delFXEventAliases,
    buttons: { Ok: true, Cancel: false }
  });
}

/**
* function: addFXEventAlias()
* Add new event alias row to database
*/
function addFXEventAlias(obj) {
  var eventid = $('#fxeventaliaslistTable #eventid').val();
  var name = $('#fxeventaliaslistTable #name').val();
  $.prompt('Click OK to confirm adding forex event alias ' + eventid + ' (' + name + ').', { buttons: { Ok: true, Cancel: false },
    callback: function(v, m, f) {
      if (v) {
        $.post("request.aspx", { "a": "addFXEventAlias", "eventid": eventid, "name": eventname }, function(response) {
          // Server response
          $.prompt(response);
          // Refresh table
          getFXEventAliases();
          // Enable add control, hide save control
          $("#saveFXEventAliasNew").hide('fast');
          $("#cancelFXEventAliasNew").hide('fast');
          $("#addFXEventAliasesTableRow").show('slow');
        });
      }
    }
  });
}

/**
* function: fnClickAddFXEventAliasesRow()
* Adds row to the FXEventAliases HTML table.
*/
function fnClickAddFXEventAliasesRow() {
  // Append it to the EventAliases table.
  $('#fxeventaliaslistTable tbody tr:first').before($sFXEventAliasesAddRowForm);
  // Focus on the first form element.
  $('#fxeventaliaslistTable #eventid').focus();
  // Enable save control, hide add control
  $("#addFXEventAliasesTableRow").hide('fast');
  $("#saveFXEventAliasNew").show('slow');
  $("#cancelFXEventAliasNew").show('slow');
}

/**
* function: fnClickFXDelEventAliasesRow()
* Adds row to the FXEventAliases  HTML table.
*/
function fnClickDelFXEventAliasesRow() {
  // Remove first row in event alias table
  $('#fxeventaliaslistTable tbody tr:first').remove();
  // Enable add control, hide save control
  $("#saveFXEventAliasNew").hide('fast');
  $("#cancelFXEventAliasNew").hide('fast');
  $("#addFXEventAliasesTableRow").show('slow');
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
* function: delCurrencies()
* Delete selected events from server
*/
function delCurrencies(v, m, f) {
  var aEvtids = [];
  if (v) { // If we clicked OK...
    // Build the list of checked checkboxes into a string that will be passed to the web service.
    $("#currencylist input[type=checkbox]:checked").each(
      function(index) {
        aEvtids.push($(this).val());
      }
    );
    // Send those currencies to Hell.
    $.post("request.aspx", { a: "delCurrencies", "evtids": aEvtids.join() }, function(response) {
      $.prompt(response);
      getCurrencies();
    });
  }
}

/**
* function: delCurrencies_Verify()
* Verify deletions before sending request to server.
*/
function delCurrencies_Verify() {
  $.prompt("Do you really want to delete these currencies? This action is permanent.", {
    submit: delCurrencies,
    buttons: { Ok: true, Cancel: false }
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
* function: delCurrencyPairs()
* Delete selected Currency Pairs from server
*/
function delCurrencyPairs(v, m, f) {
  var aEvtids = [];
  if (v) { // If we clicked OK...
    // Build the list of checked checkboxes into a string that will be passed to the web service.
    $("#currencypairlist input[type=checkbox]:checked").each(
      function(index) {
        aEvtids.push($(this).val());
      }
    );
    // Send those events to Hell.
    $.post("request.aspx", { a: "delCurrencyPairs", "evtids": aEvtids.join() }, function(response) {
      $.prompt(response);
      getCurrencyPairs();
    });
  }
}

/**
* function: delCurrencyPairs_Verify()
* Verify deletions before sending request to server.
*/
function delCurrencyPairs_Verify() {
  $.prompt("Do you really want to delete these currency pairs? This action is permanent.", {
    submit: delCurrencyPairs,
    buttons: { Ok: true, Cancel: false }
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
  $("#getFXEvents").live("click", function() {
    getFXEvents();
    return false;
  });

  // Control to delete events
  $("#delFXEvents").live("click", function() {
  delFXEvents_Verify(this);
    return false;
  });

  // Control to add event
  $("#saveFXEventNew").live("click", function() {
    addFXEvent(this);
    return false;
  });

  // Control to cancel new currency
  $("#cancelFXEventNew").live("click", function() {
    fnClickDelFXEventsRow(this);
    return false;
  });

  // Control to add FXEvent table row
  $("#addFXEventsTableRow").live("click", function() {
    fnClickAddFXEventsRow();
    return false;
  });
  
  // Control to get event aliases
  $("#getFXEventAliases").live("click", function() {
    getFXEventAliases();
    return false;
  });

  // Control to delete event alias
  $("#delFXEventAliases").live("click", function() {
    delFXEventAliases_Verify(this);
    return false;
  });

  // Control to add event alias
  $("#saveFXEventAliasNew").live("click", function() {
    addFXEventAlias(this);
    return false;
  });

  // Control to cancel new alias
  $("#cancelFXEventAliasNew").live("click", function() {
    fnClickDelFXEventAliasesRow(this);
    return false;
  });

  // Control to add FXEvent_Alias table row
  $("#addFXEventAliasesTableRow").live("click", function() {
    fnClickAddFXEventAliasesRow();
    return false;
  });
  
  // Control to get currencies
  $("#getCurrencies").live("click", function() {
    getCurrencies();
    return false;
  });

  // Control to delete currencies
  $("#delCurrencies").live("click", function() {
    delCurrencies_Verify(this);
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

  // Control to delete currency pairs
  $("#delCurrencyPairs").live("click", function() {
    delCurrencyPairs_Verify(this);
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