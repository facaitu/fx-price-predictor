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
      <div id="events">
        <h3>Events</h3>
        <div id="events_controls" class="fxcontrols-box">
          <p><a id="getEvents" class="fxcontrol-refresh" href="#">Refresh</a></p>
          <p><a id="addEventsTableRow" class="fxcontrol-add" href="#">Add Event</a></p>
          <p><a id="saveEventNew" class="fxcontrol-save" href="#">Save Event</a></p>
          <p><a id="cancelEventNew" class="fxcontrol-cancel" href="#">Cancel</a></p>
        </div>
        <div id="eventlist">
        </div>
      <div id="currencies">
        <h3>Currencies</h3>
        <div id="currencies_controls" class="fxcontrols-box">
          <p><a id="getCurrencies" class="fxcontrol-refresh" href="#">Refresh</a></p>
          <p><a id="addCurrenciesTableRow" class="fxcontrol-add" href="#">Add Currency</a></p>
          <p><a id="saveCurrencyNew" class="fxcontrol-save" href="#">Save Currency</a></p>
          <p><a id="cancelCurrencyNew" class="fxcontrol-cancel" href="#">Cancel</a></p>
        </div>
        <div id="currencylist">
        </div>
        <div id="addCurrency">
        </div>
      </div>
      <div id="currencypairs">
        <h3>Currency Pairs</h3>
        <div id="currencypairs_controls" class="fxcontrols-box">
          <p><a id="getCurrencyPairs" class="fxcontrol-refresh" href="#">Refresh</a></p>
          <p><a id="addCurrencyPairsTableRow" class="fxcontrol-add" href="#">Add Currency Pair</a></p>
          <p><a id="saveCurrencyPairNew" class="fxcontrol-save" href="#">Save Currency Pair</a></p>
          <p><a id="cancelCurrencyPairNew" class="fxcontrol-cancel" href="#">Cancel</a></p>
        </div>
        <div id="currencypairlist">
        </div>
        <div id="addCurrencyPair">
        </div>
      </div>
    </div>
    <div id="footer">
      <h3>Werd.</h3>
    </div>
    </div>
  </form>
</body>
</html>
