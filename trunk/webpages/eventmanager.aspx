<%@ Page Language="C#" AutoEventWireup="true" CodeFile="eventmanager.aspx.cs" Inherits="eventmanager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FX-Price-Predictor: Event Manager</title>
   	<style type="text/css" media="all">
			@import "css/dataTable.css";
			@import "css/ui-lightness/jquery-ui-1.8rc3.custom.css";
	  	@import "css/eventmanager.css";
  	</style>
		<script type="text/javascript" language="javascript" src="js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="js/jquery-ui-1.8rc3.custom.min.js"></script>
    <script type="text/javascript" language="javascript" src="js/jquery-impromptu.3.0.min.js"></script>
    <script type="text/javascript" language="javascript" src="js/eventmanager.js"></script>
</head>
<body id="eventmanager_page">
  <form id="form1" runat="server">
    <div id="container">
      <div id="pageHeader">
        <h1>FX-Price-Predictor</h1>
        <h2>Event Manager</h2>
      </div>
      <div id="fxevents" class="dataframe">
        <h3>Events</h3>
        <div id="fxevents_controls" class="fxcontrols-box">
          <p><a id="getFXEvents" class="fxcontrol-refresh fg-button ui-state-default ui-corner-all" href="#">Refresh</a></p>
          <p><a id="delFXEvents" class="fxcontrol-del fg-button ui-state-default ui-corner-all" href="#">Delete Event(s)</a></p>
          <p><a id="addFXEventsTableRow" class="fxcontrol-add fg-button ui-state-default ui-corner-all" href="#">Add Event</a></p>
          <p><a id="saveFXEventNew" class="fxcontrol-save fg-button ui-state-default ui-corner-all" href="#">Save Event</a></p>
          <p><a id="cancelFXEventNew" class="fxcontrol-cancel fg-button ui-state-default ui-corner-all" href="#">Cancel</a></p>
        </div>
        <div id="fxeventlist">
        </div>
      </div>
      <div id="fxeventaliases" class="dataframe">
        <h3>Event Aliases</h3>
        <div id="fxeventaliases_controls" class="fxcontrols-box">
          <p><a id="getFXEventAliases" class="fxcontrol-refresh fg-button ui-state-default ui-corner-all" href="#">Refresh</a></p>
          <p><a id="delFXEventAliases" class="fxcontrol-del fg-button ui-state-default ui-corner-all" href="#">Delete Alias(s)</a></p>
          <p><a id="addFXEventAliasesTableRow" class="fxcontrol-add fg-button ui-state-default ui-corner-all" href="#">Add Alias</a></p>
          <p><a id="saveFXEventAliasNew" class="fxcontrol-save fg-button ui-state-default ui-corner-all" href="#">Save Alias</a></p>
          <p><a id="cancelFXEventAliasNew" class="fxcontrol-cancel fg-button ui-state-default ui-corner-all" href="#">Cancel</a></p>
        </div>
        <div id="fxeventaliaslist">
        </div>
       </div>
      <div id="currencypairs" class="dataframe">
        <h3>Currency Pairs</h3>
        <div id="currencypairs_controls" class="fxcontrols-box">
          <p><a id="getCurrencyPairs" class="fxcontrol-refresh fg-button ui-state-default ui-corner-all" href="#">Refresh</a></p>
          <p><a id="delCurrencyPairs" class="fxcontrol-del fg-button ui-state-default ui-corner-all" href="#">Delete Pair(s)</a></p>
          <p><a id="addCurrencyPairsTableRow" class="fxcontrol-add fg-button ui-state-default ui-corner-all" href="#">Add Currency Pair</a></p>
          <p><a id="saveCurrencyPairNew" class="fxcontrol-save fg-button ui-state-default ui-corner-all" href="#">Save Pair</a></p>
          <p><a id="cancelCurrencyPairNew" class="fxcontrol-cancel fg-button ui-state-default ui-corner-all" href="#">Cancel</a></p>
        </div>
        <div id="currencypairlist">
        </div>
      </div>
      <div id="currencies" class="dataframe">
        <h3>Currencies</h3>
        <div id="currencies_controls" class="fxcontrols-box">
          <p><a id="getCurrencies" class="fxcontrol-refresh fg-button ui-state-default ui-corner-all" href="#">Refresh</a></p>
          <p><a id="delCurrencies" class="fxcontrol-del fg-button ui-state-default ui-corner-all" href="#">Delete Currency(s)</a></p>
          <p><a id="addCurrenciesTableRow" class="fxcontrol-add fg-button ui-state-default ui-corner-all" href="#">Add Currency</a></p>
          <p><a id="saveCurrencyNew" class="fxcontrol-save fg-button ui-state-default ui-corner-all" href="#">Save Currency</a></p>
          <p><a id="cancelCurrencyNew" class="fxcontrol-cancel fg-button ui-state-default ui-corner-all" href="#">Cancel</a></p>
        </div>
        <div id="currencylist">
        </div>
      </div>
      <div id="footer">
        <h3>Werd.</h3>
      </div>
    </div>
  </form>
</body>
</html>
