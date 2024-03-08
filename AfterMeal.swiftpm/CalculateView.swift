import SwiftUI

struct CalculateView: View {
    @Binding var nameList: [NameClass]
    @Binding var groupList: [GroupCheck]
    @Binding var foodList: [FoodClass]
    @Binding var categoryList: [CategoryCheck]
    
    @Binding var vat: RuleClass
    @Binding var serviceCharge: RuleClass
    @Binding var discount: RuleClass
    @Binding var sponsor: RuleClass
    @Binding var total: Double
    @Binding var currency: String
    
    @State var refresh: Bool = false
    @State var detailOn: Bool = false
    @State var isValid: Bool = true
    
    @State var foodPool: [String] = []
    @State var invalidFoods: [String] = []
    @State var invalidNames: [String] = []
    
    func useEffect() -> Void {
        foodPool = []
        invalidFoods = []
        invalidNames = []
        isValid = true
        
        nameList.forEach { name in
            name.Total_Exp = 0
        }
        foodList.forEach { food in
            food.count = 0
        }
        
        nameList.forEach { name in
            foodList.forEach { food in
                if (name.Foods.contains(food.Name)) {
                    food.count += 1
                    food.PriceP = food.Price / Double(food.count)
                    foodPool.append(food.Name)
                }
            }
            if (name.Foods.count == 0) { // check if name eat at least one food
                invalidNames.append(name.Name)
                isValid = false
            } // check if name eat at least one food
        } // find Price per name of food
        
        foodList.forEach { food in
            if(!foodPool.contains(food.Name)) { // check if food is selected
                invalidFoods.append(food.Name)
                isValid = false
            } // check if food is selected
        }
        
        if (isValid) {
            nameList.forEach { name in
                foodList.forEach { food in
                    if (name.Foods.contains(food.Name)) {
                        name.Total_Exp += food.PriceP
                    }
                }
            } // find total expense of each name
        }
    }
    
    func isRules() -> Bool {
        return vat.IsCheck || serviceCharge.IsCheck || discount.IsCheck || sponsor.IsCheck
    }
    
    func total_exp(total_exp: Double) -> Double {
        var total_exp_all: Double = total_exp
        if (vat.IsCheck) {
            total_exp_all += (total_exp * vat.Value) / 100
        }
        if (serviceCharge.IsCheck) {
            total_exp_all += (total_exp * serviceCharge.Value) / 100
        }
        if (discount.IsCheck) {
            total_exp_all -= discount.Value/Double(nameList.count)
        }
        if (sponsor.IsCheck) {
            total_exp_all -= sponsor.Value/Double(nameList.count)
        }
        return total_exp_all
    }
    
    func total_inc(total_exp: Double) -> Double {
        var total_exp_all: Double = total_exp
        if (vat.IsCheck) {
            total_exp_all += (total_exp * vat.Value) / 100
        }
        if (serviceCharge.IsCheck) {
            total_exp_all += (total_exp * serviceCharge.Value) / 100
        }
        if (discount.IsCheck) {
            total_exp_all -= discount.Value
        }
        if (sponsor.IsCheck) {
            total_exp_all -= sponsor.Value
        }
        return total_exp_all
    }
    
    var body: some View {
        ZStack { // ZStack
            Color.init(red: 245/255, green: 245/255, blue: 245/255) // background color
            VStack { // Screen
                VStack(spacing: 0) { // All top
                    HStack {} // above island
                        .frame(maxWidth: .infinity, maxHeight: 25)
                        .background(Color(red: 25/255, green: 155/255, blue: 225/255)) // above island color
                    HStack { // Header
                        HStack{} //adjust
                            .frame(width: 40.0, height: 40.0, alignment: .trailing)
                            .padding(.leading, 20)
                        HStack { // middle
                            Text("Calculation")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        } // middle
                            .frame(maxWidth: .infinity)
                        HStack{} // adjust / icon
                            .frame(width: 40.0, height: 40.0, alignment: .leading)
                            .padding(.trailing, 20)
                    } // Header
                        .frame(maxWidth: .infinity)
                        .padding(.top, 30)
                        .padding(.bottom, 15)
                        .padding([.leading, .trailing])
                        .background(Color(red: 25/255, green: 155/255, blue: 225/255)) // header color
                } // All top
                ScrollView {
                    VStack(spacing: 10) { // Body
                        if (nameList == [] && foodList == []) {
                            Text("Please add Food and Name")
                        } else if (nameList == []) {
                            Text("Please add Name")
                        } else if (nameList == []) {
                            Text("Please add Food")
                        } else if (!isValid) {
                            Text("Invalid")
                            VStack {
                                if (invalidNames.count > 0) {
                                    Text("Name that did not select any foods:")
                                    ForEach(invalidNames, id: \.self) { name in
                                        Text(name)
                                    }
                                }
                                if (invalidFoods.count > 0) {
                                    Text("Food that have not been selected:")
                                    ForEach(invalidFoods, id: \.self) { food in
                                        Text(food)
                                    }
                                }
                            }
                        } else {
                            Toggle(isOn: self.$detailOn, label: {
                                Text(detailOn ? "Details" : "Summary")
                                    .font(.system(size: 20))
                            })
                            VStack {
                                HStack {
                                    Text("Total (excluding rules):")
                                        .font(.system(size: 20))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(total, specifier: "%.2f") \(currency)")
                                        .font(.system(size: 20))
                                }
                                .frame(width: .infinity, alignment: .leading)
                                if (self.isRules()) {
                                    if (vat.IsCheck) {
                                        HStack {
                                            Text("Vat \(vat.Value, specifier: "%.0f") %")
                                                .font(.system(size: 20))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("+ \(total * (vat.Value/100), specifier: "%.2f") \(currency)")
                                                .font(.system(size: 20))
                                        }
                                    }
                                    if (serviceCharge.IsCheck) {
                                        HStack {
                                            Text("Service Charge \(serviceCharge.Value, specifier: "%.0f") %")
                                                .font(.system(size: 20))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("+ \(total * (serviceCharge.Value/100), specifier: "%.2f") \(currency)")
                                                .font(.system(size: 20))
                                        }
                                    }
                                    if (discount.IsCheck) {
                                        HStack {
                                            Text("Discount")
                                                .font(.system(size: 20))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("- \(discount.Value, specifier: "%.2f") \(currency)")
                                                .font(.system(size: 20))
                                        }
                                    }
                                    if (sponsor.IsCheck) {
                                        HStack {
                                            Text("Sponsor")
                                                .font(.system(size: 20))
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            Text("- \(sponsor.Value, specifier: "%.2f") \(currency)")
                                                .font(.system(size: 20))
                                        }
                                    }
                                    HStack {
                                        Text("Total (including rules):")
                                            .font(.system(size: 20))
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Text("\(total_inc(total_exp: total), specifier: "%.2f") \(currency)")
                                            .font(.system(size: 20))
                                    }
                                    .frame(width: .infinity, alignment: .leading)
                                }
                            }
                                .frame(width: .infinity, alignment: .leading)
//                                .padding([.leading, .trailing], 30)
                            if (!detailOn) { // if detailOn
                                ForEach(groupList, id:\.self) { group in //for group in
                                    if(group.IsCheck) { // if group.IsCheck
                                        VStack {// Group
                                            HStack { // Group Header
                                                Text(group.NameS)
                                                    .font(.system(size: 25))
                                                    .fontWeight(.semibold)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            } // Group Header
                                            VStack { //Names
                                                ForEach($nameList, id:\.self) { name in // for Name in group
                                                    if(groupEnumToString(group: name.wrappedValue.Group) == group.NameS) { // if
                                                        HStack { // NameItem
                                                            Text(refresh ? "\(name.wrappedValue.Name)" : "\(name.wrappedValue.Name)")
                                                                .font(.system(size: 18))
                                                                .fontWeight(.semibold)
                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                            Text("\(total_exp(total_exp: name.wrappedValue.Total_Exp), specifier: "%.2f") \(currency)")
                                                                .font(.system(size: 18))
                                                                .fontWeight(.semibold)
                                                                .frame(alignment: .trailing)
                                                        } // NameItem
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .padding(5)
                                                    } // if name in group
                                                } // for Name in group
                                            } //Names
                                        } //Group
                                        .padding()
                                        .background(.white)
                                        .cornerRadius(15)
                                        .padding(.bottom, 5)
                                    } // if group.IsCheck
                                } //for group in
                            } else { // if detailOn
                                ForEach(groupList, id:\.self) { group in // for group in
                                    if(group.IsCheck) { // if group.IsCheck
                                        VStack {// Group
                                            HStack { // Group Header
                                                Text(group.NameS)
                                                    .font(.system(size: 25))
                                                    .fontWeight(.semibold)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            } // Group Header
                                            VStack { //Names
                                                ForEach($nameList, id:\.self) { name in // for Name in group
                                                    if(groupEnumToString(group: name.wrappedValue.Group) == group.NameS) { // if
                                                        VStack { // NameItem
                                                            HStack { // NameItem head
                                                                Text("\(name.wrappedValue.Name)")
                                                                    .font(.system(size: 18))
                                                                    .fontWeight(.semibold)
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                Text("\(total_exp(total_exp: name.wrappedValue.Total_Exp), specifier: "%.2f") \(currency)")
                                                                    .font(.system(size: 18))
                                                                    .fontWeight(.semibold)
                                                                    .frame(alignment: .trailing)
                                                            } // NameItem head
                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                            VStack { // VStack before for food in name.Foods
                                                                ForEach($foodList, id:\.self) { food in // for food in name.Foods
                                                                    if(name.wrappedValue.Foods.contains(food.wrappedValue.Name)) {
                                                                        HStack {
                                                                            Text(food.wrappedValue.Name)
                                                                                .font(.system(size: 15))
                                                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                                            Text("+ \(food.wrappedValue.PriceP, specifier: "%.2f") \(currency)")
                                                                        }
                                                                    }
                                                                }
                                                                HStack {
                                                                    Text("Total (excluding rules)")
                                                                        .font(.system(size: 15))
                                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                                    Text("\(name.wrappedValue.Total_Exp, specifier: "%.2f") \(currency)")
                                                                }
                                                                .padding(.bottom, 1)
                                                                if (vat.IsCheck) {
                                                                    HStack {
                                                                        Text("Vat \(vat.Value, specifier: "%.0f") %")
                                                                            .font(.system(size: 15))
                                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                                        Text("+ \(name.wrappedValue.Total_Exp * (vat.Value/100), specifier: "%.2f") \(currency)")
                                                                    }
                                                                }
                                                                if (serviceCharge.IsCheck) {
                                                                    HStack {
                                                                        Text("Service Charge \(serviceCharge.Value, specifier: "%.2f") %")
                                                                            .font(.system(size: 15))
                                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                                        Text("+ \(name.wrappedValue.Total_Exp * (serviceCharge.Value/100), specifier: "%.2f") \(currency)")
                                                                    }
                                                                }
                                                                if (discount.IsCheck) {
                                                                    HStack {
                                                                        Text("Discount")
                                                                            .font(.system(size: 15))
                                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                                        Text("- \(discount.Value/Double(nameList.count), specifier: "%.2f") \(currency)")
                                                                    }
                                                                }
                                                                if (sponsor.IsCheck) {
                                                                    HStack {
                                                                        Text("Sponsor")
                                                                            .font(.system(size: 15))
                                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                                        Text("- \(sponsor.Value/Double(nameList.count), specifier: "%.2f") \(currency)")
                                                                    }
                                                                }
                                                                if (self.isRules()) {
                                                                    HStack {
                                                                        Text("Total (including rules)")
                                                                            .font(.system(size: 15))
                                                                            .frame(maxWidth: .infinity, alignment: .leading)
                                                                        Text("\(total_exp(total_exp: name.wrappedValue.Total_Exp), specifier: "%.2f") \(currency)")
                                                                    }
                                                                }
                                                            } // VStack before for food in name.Foods
                                                            .padding(.leading, 15)
                                                        } // Name Item
                                                        .padding(5)
                                                        .padding(.bottom, 5)
                                                    } // if name in group
                                                } // for Name in group
                                            } //Names
                                        } //Group
                                        .padding()
                                        .background(.white)
                                        .cornerRadius(15)
                                        .padding(.bottom, 5)
                                    } // if group.IsCheck
                                } // for group in
                            } // if detailOn
                        } // there's nameList and foodList
                    } //Body
                    .frame(width: .infinity)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 30)
                    Spacer()
                }
            } // Screen
        } // ZStack
        .ignoresSafeArea(edges: .top)
        .onAppear() {
            if (nameList != [] && foodList != []){
                self.useEffect()
            }
            self.refresh.toggle()
        }
    }
}

