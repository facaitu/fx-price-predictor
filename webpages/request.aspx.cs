using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;
using System.Runtime.Serialization;
using System.Text;

namespace FXEvents
{
    public partial class request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            NameValueCollection coll = new NameValueCollection(Request.Form);
            FXEventsDataContext fxdc = new FXEventsDataContext();

            switch (coll["a"])
            {
                case "getEvents":
                    IEnumerable<fxevent> fxevents = from fxe in fxdc.fxevents
                                                    select fxe;
                    Response.Write(FXTransforms.Linq2SQL_XSLTransform("fxevents", fxevents, "templates/fxevent.xslt").ToString());
                    break;
                case "getEventsAddFormRow":
                    IEnumerable<fxevent> fxeventform = from fxe in fxdc.fxevents
                                                    select fxe;
                    Response.Write(FXTransforms.Linq2SQL_XSLTransform("fxevents", fxeventform, "templates/fxevent_add.xslt").ToString());
                    break;
                case "updateEvent":

                    break;
                case "addEvent":
                    fxevent fxevt = new fxevent();
                    fxevt.currency = coll["curr"];
                    fxevt.eventid = coll["eventid"];
                    fxevt.importance = Convert.ToInt16(coll["importance"]);
                    fxevt.name = coll["name"];
                    fxevt.next_date = Convert.ToDateTime(coll["next_date"]);
                    //fxevt.next_time = Convert.ToDateTime(coll["next_time"]);
                    fxevt.previous = Convert.ToDecimal(coll["previous"]);
                    fxevt.recurring = Convert.ToByte(coll["recurring"]);
                    fxevt.watch = Convert.ToByte(coll["watch"]);

                    fxdc.fxevents.InsertOnSubmit(fxevt);
                    fxdc.SubmitChanges();
                    Response.Write("Adding " + fxevt.eventid + " (" + fxevt.name + "). Err No: " + fxevt.err_no + ", Err Desc: " + fxevt.err_desc);
                    break;
                case "getCurrencies":
                    IEnumerable<currency> currency = from fxc in fxdc.currencies
                                                    select fxc;
                    Response.Write(FXTransforms.Linq2SQL_XSLTransform("currencies", currency, "templates/currency.xslt").ToString());
                    break;
                case "getCurrenciesAddFormRow":
                    IEnumerable<currency> currencyform = from fxc in fxdc.currencies
                                                     select fxc;
                    Response.Write(FXTransforms.Linq2SQL_XSLTransform("currencies", currencyform, "templates/currency_add.xslt").ToString());
                    break;
                case "getCurrencySelect":
                    IEnumerable<currency> currencyselect = from fxc in fxdc.currencies orderby fxc.currencyid
                                                     select fxc;
                    Response.Write(FXTransforms.Linq2SQL_XSLTransform("currencies", currencyselect, "templates/currency_select.xslt").ToString());
                    break;
                case "addCurrency":
                    currency fxcurr = new currency();
                    fxcurr.currencyid = coll["curr"];
                    fxcurr.name = coll["name"];
                    
                    fxdc.currencies.InsertOnSubmit(fxcurr);
                    fxdc.SubmitChanges();
                    Response.Write("Adding " + fxcurr.currencyid + " (" + fxcurr.name + "). Err No: " + fxcurr.err_no + ", Err Desc: " + fxcurr.err_desc);
                    break;
                case "getCurrencyPairs":
                    IEnumerable<currencypair> currencypairselect = from fxc in fxdc.currencypairs
                                                     select fxc;
                    Response.Write(FXTransforms.Linq2SQL_XSLTransform("currencypairs", currencypairselect, "templates/currencypair.xslt").ToString());
                    break;
                case "getCurrencyPairsAddFormRow":
                    IEnumerable<currencypair> currencypairform = from fxc in fxdc.currencypairs
                                                         select fxc;
                    Response.Write(FXTransforms.Linq2SQL_XSLTransform("currencypairs", currencypairform, "templates/currencypair_add.xslt").ToString());
                    break;
                case "getCurrencyPairSelect":
                    IEnumerable<currencypair> currencypair = from fxc in fxdc.currencypairs
                                                             select fxc;
                    Response.Write(FXTransforms.Linq2SQL_XSLTransform("currencypairs", currencypair, "templates/currencypair_select.xslt").ToString());
                    break;
                case "addCurrencyPair":
                    currencypair fxcurrpair = new currencypair();
                    fxcurrpair.@base = coll["base"];
                    fxcurrpair.quote = coll["quote"];   
                    fxcurrpair.lastmodified = DateTime.Now;

                    fxdc.currencypairs.InsertOnSubmit(fxcurrpair);
                    fxdc.SubmitChanges();
                    Response.Write("Adding " + fxcurrpair.@base + "/" + fxcurrpair.quote + ". Err No: " + fxcurrpair.err_no + ", Err Desc: " + fxcurrpair.err_desc);
                    break;
                default:
                    // Do nothing.
                    Response.Write("Nothing to see here...");
                    break;
            }
        }
    }
}