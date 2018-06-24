using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ZP3CS_cv07
{
    class Program
    {

        static int GodCount(string s)
        {
            int count = 0;
            int i = 0;
            while ((i = s.IndexOf("God", i)) != -1)
            {
                i += "God".Length;
                count++;
            }

            return count;
        }
        
        static string AddGodCount(string si)
        {                        
            int count = 0;
            string s = string.Copy(si);
            int i = 0;
            string rstr;
            while ((i = s.IndexOf("God", i)) != -1)
            {
                i += "God".Length;
                count++;

                rstr = "(" + count + ")";
                s = s.Insert(i, rstr);
            }
            return s;    
        }

        static void Main(string[] args)
        {
            string bible = File.ReadAllText("..\\..\\..\\bible.txt");
            DateTime starttime = DateTime.Now;
            string b = AddGodCount(bible);
            File.WriteAllText("..\\..\\..\\bibleOutput.txt", b);
            Console.WriteLine("čas {0:F2}s", (DateTime.Now - starttime).TotalSeconds);
            starttime = DateTime.Now;
            Console.WriteLine(GodCount(bible));
            Console.WriteLine("čas {0:F2}s", (DateTime.Now - starttime).TotalSeconds);
        }
    }
}
