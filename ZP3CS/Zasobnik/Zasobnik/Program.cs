using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Zasobnik
{
    class Program
    {
        static void Main(string[] args)
        {

            Zasobnik<int> z = new Zasobnik<int>();
            Zasobnik<string> z2 = new Zasobnik<string>();
            Console.ReadKey();
            Console.WriteLine("Pridavame: \n1 \n2 \n3 \n4 \n5 \n6\n");

            z.pridejPrvek(1);
            z.pridejPrvek(2);
            z.pridejPrvek(3);
            z.pridejPrvek(4);
            z.pridejPrvek(5);
            z.pridejPrvek(6);
            Console.ReadKey();
            while (!z.JePrazdna()) Console.WriteLine(z.Odeber());
            Console.ReadKey();
            Console.WriteLine("\n\nPridavame: \njedna \ndva \ntri\n");

            z2.pridejPrvek("jedna");
            z2.pridejPrvek("dva");
            z2.pridejPrvek("tri");
            Console.ReadKey();
            while (!z2.JePrazdna()) Console.WriteLine(z2.Odeber());

            Console.ReadKey();
        }
    }
}
