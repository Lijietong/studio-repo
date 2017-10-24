﻿using System;

// using System.Collections.Generic;
// using System.Linq;
// using System.Web;

using System.Data;
using System.Data.SqlClient;  // for 'mssql'

// using MySql.Data.MySqlClient; // for 'mysql'

namespace DbHelper
{

    // Summary
    //   Connector 连接器 - 基类, 封装一些数据库连接的通用方法, 包含连接模式和断开模式
    //
    public class Connector
    {
        // Summary:
        //   Type of database.
        private string DbType { set; get; }

        // Summary:
        //   The database connection, will be converted(boxing and unboxing) to different database connections.
        public SqlConnection DbConnection { set; get; }

        // Summary:
        //   The connection string of database, can be getted and setted by a object. 
        public string ConnectionString { set; get; }

        // Summary:
        //   The default type of database is 'mssql'.
        public Connector()
        {
            this.DbType = "mssql";
        }

        // Summary:
        //   This constructor will set the type of database by a parameter.
        //
        // Parameters:
        //   dbType_connectionString: 
        //     The string is the type of database or connection string.
        public Connector(string dbType_connectionString)
        {
            if (dbType_connectionString != "mssql" || dbType_connectionString != "mysql")
            {
                // If input a connection string, the type of database will be setted to 'mssql'.
                this.DbType = "mssql";
                this.ConnectionString = dbType_connectionString;
            }
            else
            {
                this.DbType = dbType_connectionString;
            }
        }

        // Summary:
        //   This constructor will set the 'DbType', 'ConnectionString'.
        //
        // Parameters:
        //   dbType: 
        //     The type of database - 'mssql' or 'mysql'.
        //
        //   connectionString: 
        //     The connection string.
        public Connector(string dbType, string connectionString)
        {
            this.DbType = dbType;
            this.ConnectionString = connectionString;
        }

        // Summary:
        //   Create a database connection according to 'DbType' and 'ConnectionString' if they are not null.
        public void CreateConnection()
        {
            if (this.ConnectionString != null)
            {
                if (this.DbType == "mssql")
                {
                    this.DbConnection = new SqlConnection(this.ConnectionString); // for 'mssql'
                }
            }
        }

        // Summary:
        //   Create a database connection according to 'DbType' if it is not null.
        //
        // Parameters:
        //   connectionString:
        //     Input a connection string by user.
        public void CreateConnection(string connectionString)
        {
            if (this.DbType == "mssql")
            {
                this.DbConnection = new SqlConnection(connectionString); // for 'mssql'
            }
        }
    }

    // Summary:
    //   This class is for 'mssql', and it inherit from Connector class.
    //
    public class MsSqlConnector : Connector
    {
        // These class constructors inherit from base class.

        public MsSqlConnector() : base() { }

        public MsSqlConnector(string dbType_connectionString) : base(dbType_connectionString) { }

        public MsSqlConnector(string dbType, string connectionString) : base(dbType, connectionString) { }

        // Summary:
        //  This is a open databse method.
        public void OpenDb()
        {
            if (this.DbConnection.State != ConnectionState.Open)
            {
                this.DbConnection.Open();
            }
        }

        // Summary:
        //  This is a close databse method.
        public void CloseDb()
        {
            if (this.DbConnection.State != ConnectionState.Closed)
            {
                this.DbConnection.Close();
            }
        }

        // Summary:
        //   Close SqlDataReader.
        public  void CloseReader(SqlDataReader reader)
        {
            reader.Close();
        }

        // Summary:
        //   Close all resources.
        public void CloseAll()
        {
            // TODO
        }

        // Summary:
        //   Query database table by using 'SelectString'
        //
        // Parameters:
        //   tableName: 
        //     The data table name.
        //   
        //   ags:
        //     This is parameters array.
        //
        // Returns:
        //   Return a SqlDataReader object.
        public SqlDataReader SelectData(string tableName, params string[] args)
        {
            SqlDataReader reader = null;
            SqlCommand    cmd    = new SqlCommand();

            // 字符串拼接查询
            // cmd.CommandText = String.Format("select * from {0}", tableName);

            // 带参查询
            if (args.Length != 0)
            {
                cmd.CommandText = String.Format("select * from {0} where {1} and {2}", tableName, args[0], args[1]);

                for (int i = 0, length = args.Length / 2; i < length; i++)
                {
                    SqlParameter parms = new SqlParameter(args[i], SqlDbType.NChar, 10);
                    parms.Direction = ParameterDirection.Input;

                    // error here
                    parms.Value = args[i + length ].Trim();

                    cmd.Parameters.Add(parms);
                }
            }

            cmd.Connection  = this.DbConnection;

            reader = cmd.ExecuteReader();

            // reader.Close();

            return reader;
        }
    }

}