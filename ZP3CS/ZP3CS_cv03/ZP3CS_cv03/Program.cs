using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ZP3CS_cv03
{
    class Program
    {
        static void Main(string[] args)
        {            
            Fronta f = new Fronta();
            f.Pridej(1);
            f.Pridej(2);
            f.Pridej(3);
            f.Pridej(4);

            Prvek p = f.prvni;
            
            while (p != null)
            {
                Console.WriteLine(p.value);
                p = p.next;
            }

            while (!f.JePrazdna())
            {
                Console.WriteLine(f.Odeber());
            }

            //f.Odeber();

            Console.WriteLine("Je prazdna: " + f.JePrazdna());
        }
    }
}
