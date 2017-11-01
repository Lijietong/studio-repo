﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Update : System.Web.UI.Page
{
    MyPetShopDataContext db = new MyPetShopDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string categoryId = Request.QueryString["CategoryId"];

            var category = (from c in db.Category
                            where c.CategoryId == int.Parse(categoryId)
                            select c).First(); // First()返回记录集中的第一条记录

            txtCategoryId.Text     = categoryId;
            txtCategoryId.ReadOnly = true;     // 分类Id是标识，不能更改 
            txtName.Text           = category.Name;
            txtDescn.Text          = category.Descn;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        var category = (from c in db.Category
                        where c.CategoryId == int.Parse(txtCategoryId.Text.Trim())
                        select c).First();

        category.Name = txtName.Text.Trim();
        category.Descn = txtDescn.Text.Trim();

        db.SubmitChanges(); // 提交更改
    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("DataManage.aspx");
    }
}