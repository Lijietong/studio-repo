﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AbstractFactoryPattern
{
    interface IFoodShop
    {
        IList<Food> Foods { get; set; }
        
        string Area { get; set; }

        IList<Food> CookFoods(params string[] foodNames);
    }
}
