import Foundation
import UIKit

public enum CategoryEnum {
    case MainDish
    case SideDish
    case RegionFood
    case SpicyFood
    case VegeterianFood
    case Soup
    case Salad
    case Drink
    case Alcohol
    case Dessert
    case Category1
    case Category2
    case Category3
}

public enum GroupEnum {
    case Nogroup
    case EatAll
    case Drinker
    case SpecialList
    case Group1
    case Group2
    case Group3
}

public func categoryEnumToString(category: CategoryEnum) -> String {
    switch category {
    case .MainDish:
        return "Main Dish"
    case .SideDish:
        return "Side Dish"
    case .RegionFood:
        return "Region Food"
    case .SpicyFood:
        return "Spicy Food"
    case .VegeterianFood:
        return "Vegeterian Food"
    case .Soup:
        return "Soup"
    case .Salad:
        return "Salad"
    case .Drink:
        return "Drink"
    case .Alcohol:
        return "Alcohol"
    case .Dessert:
        return "Dessert"
    case .Category1:
        return "Category1"
    case .Category2:
        return "Category2"
    case .Category3:
        return "Category3"
    }
}

public func groupEnumToString(group: GroupEnum) -> String {
    switch group {
    case .Nogroup:
        return "No Group"
    case .EatAll:
        return "Eat All"
    case .Drinker:
        return "Drinker"
    case .SpecialList:
        return "Specialist"
    case .Group1:
        return "Group1"
    case .Group2:
        return "Group2"
    case .Group3:
        return "Group3"
    }
}


class FoodClass: NSObject {
    var Name: String
    var Price: Double
    var Category: CategoryEnum
    var count: Int = 0
    var PriceP: Double = 0
    var Photo: String
    
    override init() {
        self.Name = ""
        self.Price = 0
        self.Category = CategoryEnum.MainDish
        self.Photo = ""
    }
    
    init(Name: String, Price: Double, Category: CategoryEnum) {
        self.Name = Name
        self.Price = Price
        self.Category = Category
        self.Photo = ""
    }
    
    init(Name: String, Price: Double, Category: CategoryEnum, Photo: String) {
        self.Name = Name
        self.Price = Price
        self.Category = Category
        self.Photo = Photo
    }
}

class FoodCheck: NSObject {
    var Name: String
    var Category: CategoryEnum
    var IsCheck: Bool = true
    
    override init() {
        self.Name = ""
        self.IsCheck = true
        self.Category = CategoryEnum.MainDish
    }
    
    init(Name: String, IsCheck: Bool, Category: CategoryEnum) {
        self.Name = Name
        self.IsCheck = IsCheck
        self.Category = Category
    }
}

class CategoryCheck: NSObject {
    var Name: CategoryEnum
    var NameS: String
    var count: Int
    var len: Int
    var IsCheck: Bool = true
    
    init(Name: CategoryEnum, count: Int, len: Int, IsCheck: Bool) {
        self.Name = Name
        self.NameS = categoryEnumToString(category: Name)
        self.count = count
        self.len = len
        self.IsCheck = IsCheck
    }
    
    override init() {
        self.Name = CategoryEnum.MainDish
        self.NameS = "Main Food"
        self.count = 0
        self.len = 0
        self.IsCheck = true
    }
}

class GroupCheck: NSObject {
    var Name: GroupEnum
    var NameS: String
    var IsCheck: Bool = false
    var count: Int = 0
    
    init(Name: GroupEnum, IsCheck: Bool) {
        self.Name = Name
        self.NameS = groupEnumToString(group: Name)
        self.IsCheck = IsCheck
    }
}

class NameClass: NSObject {
    var Name: String
    var Group: GroupEnum
    var Foods: [String]
    var Categories: [String] = []
    var EatAll: Bool
    var Photo: String
    var Total_Exp: Double = 0
    
    init(Name: String, Group: GroupEnum, Foods: [String], Categories: [String], EatAll: Bool) {
        self.Name = Name
        self.Group = Group
        self.Foods = Foods
        self.Categories = Categories
        self.EatAll = EatAll
        self.Photo = ""
    }
    
    init(Name: String, Group: GroupEnum, Foods: [String], Categories: [String], EatAll: Bool, Photo: String) {
        self.Name = Name
        self.Group = Group
        self.Foods = Foods
        self.Categories = Categories
        self.EatAll = EatAll
        self.Photo = Photo
    }
    
    override init() {
        self.Name = ""
        self.Group = GroupEnum.Nogroup
        self.Foods = []
        self.EatAll = true
        self.Photo = ""
    }
}

class RuleClass: NSObject {
    var Name: String
    var Role: String
    var Value: Double
    var IsCheck: Bool
    
    init(Name: String, Role: String, Value: Double, IsCheck: Bool) {
        self.Name = Name
        self.Role = Role
        self.Value = Value
        self.IsCheck = IsCheck
    }
}
