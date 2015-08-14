using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Repair
{
    public Repair() { } //constructor
    public int RepairID { get; set; }
    public int CustomerID { get; set; }
    public string ProductCode { get; set; }
    public int TechID { get; set; }
    public DateTime DateReported { get; set; }    
    public DateTime? DateRepaired { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }	
}