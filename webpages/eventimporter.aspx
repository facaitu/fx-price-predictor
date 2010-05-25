<%@ Page Language="C#" AutoEventWireup="true" CodeFile="eventimporter.aspx.cs" Inherits="css_eventimporter" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FX-Price-Predictor: Event Importer</title>
   	<style type="text/css" media="all">
			@import "css/dataTable.css";
			@import "css/ui-lightness/jquery-ui-1.8rc3.custom.css";
	  	@import "css/eventmanager.css";
  	</style>
		<script type="text/javascript" language="javascript" src="js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" language="javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="js/jquery-ui-1.8rc3.custom.min.js"></script>
    <script type="text/javascript" language="javascript" src="js/jquery-impromptu.3.0.min.js"></script>
    <script type="text/javascript" language="javascript" src="js/eventimporter.js"></script>
</head>
<body id="eventimporter_page">
    <form id="form1" runat="server">
    <div id="container">
      <div id="pageHeader">
        <h1>FX-Price-Predictor</h1>
        <h2>Event Importer</h2>
      </div>
      <div id="fxevents" class="dataframe">
        <h3>Events</h3>
        <div id="fxevents_controls" class="fxcontrols-box">
          <p><a id="forceFeedDownload" class="fxcontrol-refresh fg-button ui-state-default ui-corner-all" href="#">Force a Manual Feed Download</a></p>
          <p><a id="getFXEventsStaging" class="fxcontrol-refresh fg-button ui-state-default ui-corner-all" href="#">Refresh</a></p>
          <p><a id="addFXEvents_Import" class="fxcontrol-save fg-button ui-state-default ui-corner-all" href="#">Import Selected Staged Events</a></p>
        </div>
        <div id="fxeventlist">
        </div>
        <div id="fxeventstagingfeed">
        </div>
      </div>
    </div>
    </form>
</body>
</html>
