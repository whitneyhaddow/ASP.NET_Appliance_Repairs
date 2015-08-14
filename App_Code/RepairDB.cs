using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

[DataObject(true)] //annotation of data access class
public class RepairDB
{
    //GET ALL REPAIRS BY TECH
    [DataObjectMethod(DataObjectMethodType.Select)] //annotate data object select method
    public static List<Repair> GetRepairsByTechnician(string technician)
    {
        List<Repair> RepairsList = new List<Repair>();  
        SqlConnection connect = new SqlConnection(AppRepairsDB.GetConnectionString());
        string select = "SELECT RepairID, DateReported, Title, Description, CustomerID, ProductCode, DateRepaired " +
                       "FROM Repairs " +
                       "WHERE TechID = @TechID " + 
                       "ORDER BY DateReported";
        SqlCommand command = new SqlCommand(select, connect); 
        command.Parameters.AddWithValue("TechID", technician); 
        connect.Open();
        SqlDataReader dr = command.ExecuteReader();

        //temp objects for iteration
        Repair i;
        DateTime dt = new DateTime();
        DateTime? nullableDT = new DateTime?();

        while (dr.Read()) 
        {
            i = new Repair();
            i.RepairID = (int)dr["RepairID"];
            i.DateReported = (DateTime)dr["DateReported"];
            i.Title = dr["Title"].ToString();
            i.Description = dr["Description"].ToString();
            i.CustomerID = (int)dr["CustomerID"];
            i.ProductCode = dr["ProductCode"].ToString();
            string date = dr["DateRepaired"].ToString();
            if (DateTime.TryParse(date, out dt))
            {
                nullableDT = dt;
                i.DateRepaired = nullableDT;
            }
            else
            {
                i.DateRepaired = null;
            }
            RepairsList.Add(i);
        }
        connect.Close();
        return RepairsList;
    }

    //UPDATE REPAIR EDITS
    [DataObjectMethod(DataObjectMethodType.Update)]
    public static int UpdateRepair(Repair original_Repair, Repair Repair)
    {
        int count = 0; //counter for how many rows get updated
        SqlConnection connect = new SqlConnection(AppRepairsDB.GetConnectionString());
        string update = "UPDATE Repairs " +
                        "SET DateRepaired = @newDateRepaired, " +
                        "Description = @newDescription " +
                        "WHERE RepairID = @original_RepairID " + //concurrency
                        "AND ProductCode = @original_ProductCode " +
                        "AND DateReported = @original_DateReported " +
                        "AND (DateRepaired = @original_DateRepaired " +
                                "OR DateRepaired IS NULL " +
                                "AND @original_DateRepaired IS NULL) " +
                        "AND Title = @original_Title " +
                        "AND Description = @original_Description";
        SqlCommand cmd = new SqlCommand(update, connect);

        //deal with null dates
        if (Repair.DateRepaired.HasValue)
            cmd.Parameters.AddWithValue("newDateRepaired", Repair.DateRepaired);
        else
            cmd.Parameters.AddWithValue("newDateRepaired", DBNull.Value);

        cmd.Parameters.AddWithValue("newDescription", Repair.Description);
        cmd.Parameters.AddWithValue("original_RepairID", original_Repair.RepairID);
        cmd.Parameters.AddWithValue("original_ProductCode", original_Repair.ProductCode);
        cmd.Parameters.AddWithValue("original_DateReported", original_Repair.DateReported);

        //deal with null dates from the original_Repair object
        if (original_Repair.DateRepaired.HasValue)
            cmd.Parameters.AddWithValue("original_DateRepaired", original_Repair.DateRepaired);
        else
            cmd.Parameters.AddWithValue("original_DateRepaired", DBNull.Value);

        cmd.Parameters.AddWithValue("original_Title", original_Repair.Title);
        cmd.Parameters.AddWithValue("original_Description", original_Repair.Description);

        connect.Open();
        count = cmd.ExecuteNonQuery(); //run the update as the count
        connect.Close();
        return count;
    }
}