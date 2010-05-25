using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;
using System.Xml.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Net;
using System.IO;
using mshtml;

namespace FXEvents
{
    /// <summary>
    /// Summary description for FXTransforms
    /// </summary>
    public class FXTransforms
    {
        public FXTransforms()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static StringBuilder Linq2SQL_XSLTransform(string dataset, object linqobj, string trfpath)
        {
            // Set up serialization and XML objects.
            StringBuilder sb = new StringBuilder();
            XmlWriter writer = XmlWriter.Create(sb);
            XmlDocument xdoc = new XmlDocument();
            XslCompiledTransform xtf = new XslCompiledTransform();
            XPathNavigator xpn;
            DataContractSerializer dcs;

            switch (dataset)
            {
                case "fxevents":
                    dcs = new DataContractSerializer(typeof(IEnumerable<fxevent>));
                    break;
                case "fxevent_aliases":
                    dcs = new DataContractSerializer(typeof(IEnumerable<fxevent_alias>));
                    break;
                case "fxevents_associations":
                    dcs = new DataContractSerializer(typeof(IEnumerable<fxevent_association>));
                    break;
                case "fxevents_transactions":
                    dcs = new DataContractSerializer(typeof(IEnumerable<fxevent_transaction>));
                    break;
                case "fxevents_currencypairs":
                    dcs = new DataContractSerializer(typeof(IEnumerable<fxevent_currencypair>));
                    break;
                case "fxevents_staging":
                    dcs = new DataContractSerializer(typeof(IEnumerable<fxevent_staging>));
                    break;
                case "currencies":
                    dcs = new DataContractSerializer(typeof(IEnumerable<currency>));
                    break;
                case "currencypairs":
                    dcs = new DataContractSerializer(typeof(IEnumerable<currencypair>));
                    break;
                default:
                    return sb;
                    break;
            }

            dcs.WriteObject(writer, linqobj);
            writer.Close();
            xdoc.LoadXml(sb.Replace("xmlns=\"http://schemas.datacontract.org/2004/07/\"", "").ToString());
            xpn = xdoc.CreateNavigator();
            xtf.Load(HttpContext.Current.Server.MapPath(trfpath));
            sb = new StringBuilder();
            writer = XmlWriter.Create(sb);
            xtf.Transform(xpn, writer);
            writer.Close();
            return sb;
        }

        public static bool WriteWebFeedToDB_ForexFactory_com()
        {
            XDocument feed = XDocument.Load(ConfigurationSettings.AppSettings["WebFeed_ForexFactory_com"]);
            FXEventsDataContext fxdc = new FXEventsDataContext();
            var feedpost = from post in feed.Descendants("event")

                           select new fxevent_staging
                           {
                               name = post.Element("title").Value,
                               next_date = DateTime.Parse(post.Element("date").Value),
                               next_time = TimeSpan.Parse(post.Element("time").Value),
                               recurring = 1,
                               watch = 0,
                               importance = (post.Element("impact").Value) == "Medium" ? (short)2 : (short)1,
                               previous = Convert.ToDecimal(post.Element("previous").Value),
                               currency = post.Element("country").Value
                           };

            fxdc.fxevent_stagings.InsertAllOnSubmit(feedpost);
            fxdc.SubmitChanges();
            return true;
        }

        public static StringBuilder GetWebFeed_ForexFactory_com()
        {
            // Set up serialization and XML objects.
            StringBuilder sb = new StringBuilder();
            XmlWriter writer = XmlWriter.Create(sb);
            XmlDocument xdoc = new XmlDocument();
            XslCompiledTransform xtf = new XslCompiledTransform();
            XPathNavigator xpn;

            if (ConfigurationSettings.AppSettings["WebFeed_ForexFactory_com"] != null)
            {
                // Get the feed in a StringBuilder object.
                sb = GetWebpage(ConfigurationSettings.AppSettings["WebFeed_ForexFactory_com"]);
            }

            xdoc.LoadXml(sb.ToString());
            xpn = xdoc.CreateNavigator();
            xtf.Load(HttpContext.Current.Server.MapPath("templates/webfeed_forexfactory_com.xslt"));
            sb = new StringBuilder();
            writer = XmlWriter.Create(sb);
            xtf.Transform(xpn, writer);
            writer.Close();
            return sb;
        }

        public static StringBuilder GetWebFeed_FXStreet_com()
        {
            StringBuilder sb;

            if (ConfigurationSettings.AppSettings["WebFeed_FXStreet_com"] != null)
            {
                // Get the feed in a StringBuilder object.
                IHTMLDocument2 oDoc = GetWebpageDocument(ConfigurationSettings.AppSettings["WebFeed_FXStreet_com"]);
    
                // Extract the Event objects from the returned HTML feed doc.


                // Return modified doc as a StringBuilder object.
                sb = new StringBuilder(oDoc.ToString());
                return sb;
            }
            else
            {
                return null;
            }
        }

        public static IHTMLDocument2 GetWebpageDocument(string sUrl)
        {
            StringBuilder sb = GetWebpage(sUrl);

            //reads the html into an html document to enable parsing    
            IHTMLDocument2 doc = new HTMLDocumentClass();
            doc.write(new object[] { sb.ToString() });
            doc.close();

            return doc;
        }

        public static StringBuilder GetWebpage(string sUrl)
        {
            // used to build entire input
            StringBuilder sb = new StringBuilder();

            // used on each read operation
            byte[] buf = new byte[8192];

            // we will read data via the response stream
            Stream resStream = GetWebpageStream(sUrl);

            string tempString = null;
            int count = 0;

            do
            {
                // fill the buffer with data
                count = resStream.Read(buf, 0, buf.Length);

                // make sure we read some data
                if (count != 0)
                {
                    // translate from bytes to ASCII text
                    tempString = Encoding.ASCII.GetString(buf, 0, count);

                    // continue building the string
                    sb.Append(tempString);
                }
            }
            while (count > 0); // any more data to read?

            // return page source
            return sb;
        }

        public static Stream GetWebpageStream(string sUrl)
        {
            // prepare the web page we will be asking for
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(sUrl);

            // execute the request
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();

            // we will read data via the response stream
            return response.GetResponseStream();
        }
    }
}