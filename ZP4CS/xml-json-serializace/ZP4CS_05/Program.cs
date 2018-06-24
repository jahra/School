using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml;
using System.Web.Script.Serialization;
using System.Collections;
using System.Text;
using System.Xml.Serialization;

namespace ZP4CS_05
{

    public class Program
    {
        static void Ukol1()
        {
            string filePath = @"..\..\..\data\studentiPredmetu.xml";
            XmlDocument doc = new XmlDocument();
            try
            {
                doc.Load(filePath);
            }
            catch (FileNotFoundException e)
            {                
                Console.WriteLine(e.Message); 
            }

            XmlNodeList nodeList = doc.GetElementsByTagName("studentPredmetu");                        
            StudentPredmetu student;
            bool prvni = true;            

            TextWriter tw = new StreamWriter(@"..\..\..\data\StudentsSerialize.json");
            tw.Write("{\"ucitel\": [");
            foreach (XmlNode node in nodeList)
            {
                //Console.WriteLine(node.Name);
                student = new StudentPredmetu();
                foreach (XmlNode child in node.ChildNodes)
                {
                    switch (child.Name)
                    {
                        case "osCislo":
                            student.osCislo = child.InnerText;
                            break;
                        case "jmeno":
                            student.jmeno = child.InnerText;
                            break;
                        case "prijmeni":
                            student.prijmeni = child.InnerText;
                            break;
                        case "stav":
                            student.stav = child.InnerText;
                            break;
                        case "userName":
                            student.userName = child.InnerText;
                            break;
                        case "stprIdno":
                            student.stprIdno = child.InnerText;
                            break;
                        case "nazevSp":
                            student.nazevSp = child.InnerText;
                            break;
                        case "fakultaSp":
                            student.fakultaSp = child.InnerText;                            
                            break;
                        case "kodSp":
                            student.kodSp = child.InnerText;
                            break;
                        case "formaSp":
                            student.formaSp = child.InnerText;
                            break;
                        case "typSp":
                            student.typSp = child.InnerText;
                            break;
                        case "czvSp":
                            student.czvSp = child.InnerText;
                            break;
                        case "mistoVyuky":
                            student.mistoVyuky = child.InnerText;
                            break;
                        case "rocnik":
                            student.rocnik = child.InnerText;
                            break;
                        case "oborKomb":
                            student.oborKomb = child.InnerText;
                            break;
                        case "oborIdnos":
                            student.oborIdnos = child.InnerText;
                            break;
                        case "evidovanBankovniUcet":
                            student.evidovanBankovniUcet = child.InnerText;
                            break;
                        case "statutPredmetuatutPredmetu":
                            student.statutPredmetuatutPredmetu = child.InnerText;
                            break;                        
                    }
                }
                if(student.rocnik == "2")
                {
                    string json = new JavaScriptSerializer().Serialize(student);
                    if (!prvni) tw.Write(",");
                    else prvni = false;                  
                    tw.Write(json);
                }

            }
            tw.Write("]}]");
            tw.Close();
        }

        static void Ukol2()
        {            
            string json = File.ReadAllText(@"..\..\..\data\uciteleKatedry.json");            

            var ucaList = new JavaScriptSerializer().Deserialize<List<Ucitel>>(json);

            XmlDocument doc = new XmlDocument();
            XmlDeclaration xmlDeclaration = doc.CreateXmlDeclaration("1.0", "UTF-8", null);
            XmlElement root = doc.DocumentElement;
            doc.InsertBefore(xmlDeclaration, root);
            XmlElement ucitele = doc.CreateElement("ucitele");
            foreach (var uc in ucaList)
            {                

                if (uc.jmeno == "Petr")
                {
                    XmlElement ucitel = doc.CreateElement("ucitel");
                    XmlElement ucitIdno = doc.CreateElement("ucitIdno");
                    ucitIdno.InnerText = uc.ucitIdno;
                    ucitel.AppendChild(ucitIdno);
                    XmlElement jmeno = doc.CreateElement("jmeno");
                    jmeno.InnerText = uc.jmeno;
                    ucitel.AppendChild(jmeno);
                    XmlElement prijmeni = doc.CreateElement("prijmeni");
                    prijmeni.InnerText = uc.prijmeni;
                    ucitel.AppendChild(prijmeni);
                    XmlElement titulPred = doc.CreateElement("titulPred");
                    titulPred.InnerText = uc.titulPred;
                    ucitel.AppendChild(titulPred);
                    XmlElement titulZa = doc.CreateElement("titulZa");
                    titulZa.InnerText = uc.titulZa;
                    ucitel.AppendChild(titulZa);
                    XmlElement platnost = doc.CreateElement("platnost");
                    platnost.InnerText = uc.platnost;
                    ucitel.AppendChild(platnost);
                    XmlElement zamestnanec = doc.CreateElement("zamestnanec");
                    zamestnanec.InnerText = uc.zamestnanec;
                    ucitel.AppendChild(zamestnanec);
                    XmlElement katedra = doc.CreateElement("katedra");
                    katedra.InnerText = uc.katedra;
                    ucitel.AppendChild(katedra);
                    XmlElement pracovisteDalsi = doc.CreateElement("pracovisteDalsi");
                    pracovisteDalsi.InnerText = uc.pracovisteDalsi;
                    ucitel.AppendChild(pracovisteDalsi);
                    XmlElement email = doc.CreateElement("email");
                    email.InnerText = uc.email;
                    ucitel.AppendChild(email);
                    XmlElement telefon = doc.CreateElement("telefon");
                    telefon.InnerText = uc.telefon;
                    ucitel.AppendChild(telefon);
                    XmlElement telefon2 = doc.CreateElement("telefon2");
                    telefon2.InnerText = uc.telefon2;
                    ucitel.AppendChild(telefon2);
                    XmlElement url = doc.CreateElement("url");
                    url.InnerText = uc.url;
                    ucitel.AppendChild(url);
                    ucitele.AppendChild(ucitel);
                }
            }
            doc.AppendChild(ucitele);
            XmlTextWriter xmlTextWriter = new XmlTextWriter(@"..\..\..\data\out.xml", Encoding.UTF8);
            xmlTextWriter.Formatting = Formatting.Indented;
            doc.WriteContentTo(xmlTextWriter);
            xmlTextWriter.Close();            
        }

        public static void Main()
        {
            Ukol1();
            Ukol2();            
        }    
    }
}