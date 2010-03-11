using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;
using System.Runtime.Serialization;
using System.Text;

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
    }
}