using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CMD
{
    class Program
    {
        static string path = "";

        static void printArray<T>(IEnumerable<T> arr)
        {
            foreach (var item in arr)
            {
                Console.Write($"{item}\t");
            }
            Console.WriteLine();
        }

        static void drives()
        {
            foreach (var drive in DriveInfo.GetDrives())
            {
                if (drive.IsReady)
                    Console.WriteLine($"{ drive.Name } Total space: { drive.TotalSize } Free space: { drive.TotalFreeSpace }");
            }
        }

        static DirectoryInfo[] dir()
        {
            DirectoryInfo[] dir_inf = new DirectoryInfo(path).GetDirectories();
            return dir_inf;
        }

        static void cd(string directory)
        {
            DirectoryInfo[] dirinfo = dir();
            foreach (var dir in dirinfo)
            {
                if (dir.Name == directory)
                {
                    path += directory + "\\";
                    Console.WriteLine(path);
                }
            }
        }

        static void cmd()
        {
            string read;
            string[] splitted;

            do
            {
                Console.Write("Zadejte pocatecni adresar: ");
                path = Console.ReadLine();
            } while (!Directory.Exists(path));


            while (true)
            {
                Console.Write(path + ">");

                read = Console.ReadLine();
                splitted = read.Split(' ');

                switch (splitted[0])
                {
                    case "drives":
                        drives();
                        break;
                    case "dir":
                        printArray(dir());
                        break;
                    case "cd":
                        try
                        {
                            cd(splitted[1]);
                        }
                        catch {}                                                           
                        break;                        
                    case "exit":
                        return;
                }
            }
        }

        static void Main(string[] args)
        {
            cmd();
        }
    }
}
