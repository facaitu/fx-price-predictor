var $oFXEventsTable, $sCurrSelect, $sEvtSelect, $sEvtAliasSelect;

$(document).ready(function() {
  bindFXEventsControls();

  getFXEventsStaging();
  getFXEventsSelect();
  getCurrencySelect();
  getFXEventAliasesSelect();
});

/**
 * function: getFXEventsStaging()
 * Load staged event list html block from server
 */
function getFXEventsStaging() {
  $.post("request.aspx", { a: "getFXEventsStaging" }, function(response) {
    $("#fxeventlist").html("").append(response);
    $oFXEventsTable = $("#fxeventlistTable").dataTable();
  });
}

/**
* function: addFXEvents_Import()
* Add new event rows to database from staging
*/
function addFXEvents_Import(v, m, f) {
  var aEvtids = [];
  if (v) { // If we clicked OK...
    // Build the list of checked checkboxes into a string that will be passed to the web service.
    $("#fxeventlist input[type=checkbox]:checked").each(
      function(index) {
        aEvtids.push($(this).val());
      }
    );
    // Send those staged events to live.
     $.post("request.aspx", { a: "addFXEvent_Import", "evtids": aEvtids.join() }, function(response) {
      $.prompt(response);
      getFXEventsStaging();
    });
  }
}

/**
* function: addFXEvents_Import_Verify()
* Verify that the user intends to import all checked events from the staging table into the event table.
*/
function addFXEvents_Import_Verify() {
  $.prompt("Press OK to confirm the import of these FX Events.", {
    submit: addFXEvents_Import,
    buttons: { Ok: true, Cancel: false }
  });
}

/**
* function: getFXEventsSelect()
* Load event select list html block from server
*/
function getFXEventsSelect() {
  $.post("request.aspx", { a: "getFXEventsSelect" }, function(response) {
    $sEvtSelect = response.replace(/<\?xml(?:.|\s)*?>/g, "");
  });
}

/**
* function: getCurrencySelect()
* Load currency pair list html select block from server
*/
function getCurrencySelect() {
  $.post("request.aspx", { a: "getCurrencySelect" }, function(response) {
    $sCurrSelect = response.replace(/<\?xml(?:.|\s)*?>/g, "");
  });
}

/**
* function: getFXEventAliasesSelect()
*
*/
function getFXEventAliasesSelect() {
  $.post("request.aspx", { a: "getFXEventAliasesSelect" }, function(response) {
    $sEvtAliasSelect = response.replace(/<\?xml(?:.|\s)*?>/g, "");
});
}

/**
* function: downloadFXEventsStagingFeed()
*
*/
function downloadFXEventsStagingFeed() {
  $.post("request.aspx", { a: "downloadFXEventsStagingFeed" }, function(response) {
    //$("#fxeventstagingfeed").html("").append(response);
    getFXEventsStaging();
  });
}

/**
* function: bindFXEventsControls()
* Runs on page load to bind javascript functions to HTML controls.
*/
function bindFXEventsControls() {
  // Control to get events
  $("#getFXEventsStaging").live("click", function() {
    getFXEventsStaging();
    return false;
  });

  // Control to add event
  $("#addFXEvents_Import").live("click", function() {
    addFXEvents_Import_Verify();
    return false;
  });

  // Control to force a manual download of the events feed into the staging database.
  $("#forceFeedDownload").live("click", function() {
    downloadFXEventsStagingFeed();
    return false;
  });

  // toggles the Events list on clicking the noted link  
  $('div#events h3').live("click", function() {
    $('#eventlist').slideToggle(800);
    return false;
  });
}