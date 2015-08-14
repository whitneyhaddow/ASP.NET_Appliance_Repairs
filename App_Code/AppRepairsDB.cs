using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

public class AppRepairsDB
{
    //retrieve connection string from web.config
    public static string GetConnectionString()
    {
        return ConfigurationManager.ConnectionStrings["AppRepairsConnectionString"].ConnectionString;
    }
}