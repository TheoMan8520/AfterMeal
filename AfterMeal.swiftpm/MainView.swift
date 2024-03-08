import SwiftUI

struct MainView: View {
    @State private var total: Double = 0
    @State private var currency: String = "฿"
    @State private var vat: RuleClass = RuleClass(Name: "Vat", Role: "%", Value: 7, IsCheck: true)
    @State private var serviceCharge: RuleClass = RuleClass(Name: "Service Charge", Role: "%", Value: 10, IsCheck: true)
    @State private var discount: RuleClass = RuleClass(Name: "Discount", Role: "-", Value: 0, IsCheck: false)
    @State private var sponsor: RuleClass = RuleClass(Name: "Sponsor", Role: "-", Value: 0, IsCheck: false)

    @State private var nameList: [NameClass] = []
    @State private var foodList: [FoodClass] = []
    
    @State private var groupList: [GroupCheck] = [
        GroupCheck(Name: GroupEnum.Nogroup, IsCheck: false),
        GroupCheck(Name: GroupEnum.EatAll, IsCheck: false),
        GroupCheck(Name: GroupEnum.Drinker, IsCheck: false),
        GroupCheck(Name: GroupEnum.SpecialList, IsCheck: false),
        GroupCheck(Name: GroupEnum.Group1, IsCheck: false),
        GroupCheck(Name: GroupEnum.Group2, IsCheck: false),
        GroupCheck(Name: GroupEnum.Group3, IsCheck: false),
    ]
    
    @State private var categoryList: [CategoryCheck] = [
//        CategoryCheck(Name: CategoryEnum.MainDish, count: 3, len: 0, IsCheck: true),
        CategoryCheck(Name: CategoryEnum.MainDish, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.SideDish, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.RegionFood, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.SpicyFood, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.VegeterianFood, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.Soup, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.Salad, count: 0, len: 0, IsCheck: false),
//        CategoryCheck(Name: CategoryEnum.Drink, count: 1, len: 0, IsCheck: true),
//        CategoryCheck(Name: CategoryEnum.Alcohol, count: 2, len: 0, IsCheck: true),
        CategoryCheck(Name: CategoryEnum.Drink, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.Alcohol, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.Dessert, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.Category1, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.Category2, count: 0, len: 0, IsCheck: false),
        CategoryCheck(Name: CategoryEnum.Category3, count: 0, len: 0, IsCheck: false),
    ]
    
    var body: some View {
        TabView {
            FoodListView(nameList: self.$nameList, foodList: self.$foodList, categoryList: self.$categoryList, total: self.$total, currency: self.$currency)
                .tabItem{
                    Label("Food List", systemImage: "fork.knife.circle")
                }
                .preferredColorScheme(.light)
            NameListView(nameList: self.$nameList, foodList: self.$foodList, groupList: self.$groupList)
                .tabItem{
                    Label("Name List", systemImage: "person.crop.square")
                }
                .preferredColorScheme(.light)
            RuleView(vat: self.$vat, serviceCharge: self.$serviceCharge, discount: self.$discount, sponsor: self.$sponsor, currency: self.$currency)
                .tabItem{
                    Label("Rules", systemImage: "r.circle.fill")
                }
                .preferredColorScheme(.light)
            CalculateView(nameList: self.$nameList, groupList: self.$groupList, foodList: self.$foodList, categoryList: self.$categoryList, vat: self.$vat, serviceCharge: self.$serviceCharge, discount: self.$discount, sponsor: self.$sponsor, total: self.$total, currency: self.$currency)
                .tabItem{
                    Label("Calculation", systemImage: "list.bullet.clipboard.fill")
                }
                .preferredColorScheme(.light)
        }
        .accentColor(.blue)
        .toolbarColorScheme(.light, for: .tabBar)
    }
}
