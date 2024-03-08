import SwiftUI

struct FoodListView: View {
    @Binding var nameList: [NameClass]
    @Binding var foodList: [FoodClass]
    @Binding var categoryList: [CategoryCheck]
    @Binding var total: Double
    @Binding var currency: String
    
    @State var editIsOn = false
    @State var deleteIsOn = false
    @State var refresh: Bool = false
    
    func uncheckCategory(categoryItem: CategoryCheck) -> Void {
        categoryList.forEach { category in
            if(category.Name == categoryItem.Name) {
                category.count -= 1
                if (category.count == 0) {
                    category.IsCheck = false
                    nameList.forEach { name in
                        if(name.Categories.contains(category.NameS)) {
                            name.Categories.remove(at:name.Categories.firstIndex(of: category.NameS)!)
                        }
                    }
                }
            }
        }
    }
    
    func deleteFoodFromName(food: String) -> Void {
        nameList.forEach { name in
            if (name.Foods.contains(food)) {
                name.Foods.remove(at:name.Foods.firstIndex(of: food)!)
            }
        }
    }
    
    var body: some View {
        NavigationStack { // NavigationView
            ZStack { // ZStack
                Color.init(red: 245/255, green: 245/255, blue: 245/255) // background color
                VStack { // Screen
                    VStack(spacing: 0) { // All top
                        HStack {} // above island
                            .frame(maxWidth: .infinity, maxHeight: 25)
                            .background(.pink) // above island color
                        HStack { // Header
                            HStack{
                                NavigationLink(destination: GuideView()) {
                                    Image(systemName: "questionmark.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color.white)
                                        .frame(width: 30.0, height: 30.0)
                                }
                            } //adjust
                                .frame(width: 40.0, height: 40.0, alignment: .trailing)
                                .padding(.leading, 20)
                            HStack { // middle
                                Text("Food List")
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            } // middle
                                .frame(maxWidth: .infinity)
                            HStack{ // adjust / icon
                                NavigationLink(destination: AddFoodView(nameList: self.$nameList, foodList: self.$foodList, categoryList: self.$categoryList, total: self.$total)) {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(Color.white)
                                        .frame(width: 30.0, height: 30.0)
                                }
                            } // adjust / icon
                                .frame(width: 40.0, height: 40.0, alignment: .leading)
                                .padding(.trailing, 20)
                        } // Header
                            .frame(maxWidth: .infinity)
                            .padding(.top, 30)
                            .padding(.bottom, 15)
                            .padding([.leading, .trailing])
                            .background(.pink) // header color
                    } // All top
                    VStack(spacing: 10) { // Body
                        if (foodList == []) {
                            VStack {
                                Text("No Food added")
                                    .padding(.bottom, 20)
                                Text("If this is your first time, go check out")
                                Text("the guide on the question mark left top.")
                            }
                        } else { //else
                            Section {
                                Picker("", selection: $currency) {
                                    Text("$").tag("$")
                                    Text("฿").tag("฿")
                                }
                                .pickerStyle(.segmented)
                            }
                            HStack {
                                Text("Total (excluding rules):")
                                    .font(.system(size: 20))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text("\(total, specifier: "%.2f") \(currency)")
                                    .font(.system(size: 20))
                            }
                            .frame(width: .infinity, alignment: .leading)
                            ScrollView { // ScrollView
                                ForEach(categoryList, id:\.self) { category in //for category in
                                    if(category.IsCheck) {
                                        VStack {// Category
                                            HStack { // Category Header
                                                Text(refresh ? category.NameS : category.NameS)
                                                    .font(.system(size: 25))
                                                    .fontWeight(.semibold)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            } // Category Header
                                            VStack { //Foods
                                                ForEach(self.$foodList, id:\.self) { food in // for Name in group
                                                    if(categoryEnumToString(category: food.wrappedValue.Category) == category.NameS) { // if
                                                        HStack { // NameItem
                                                            Text(food.wrappedValue.Photo)
                                                                .font(.system(size: 45))
                                                                .frame(width: 55, height: 55)
                                                            VStack(spacing: 5) {
                                                                Text(refresh ? "\(food.wrappedValue.Name)" : "\(food.wrappedValue.Name)")
                                                                    .font(.system(size: 15))
                                                                    .fontWeight(.semibold)
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                                Text("\(currency) \(food.wrappedValue.Price, specifier: "%.2f")")
                                                                    .font(.system(size: 15))
                                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                            }
                                                            .frame(maxWidth: .infinity, maxHeight: 40, alignment: .topLeading)
                                                            HStack {
                                                                NavigationLink(
                                                                    destination: EditFoodView(nameList: self.$nameList, foodItem: food, categoryList: self.$categoryList, total: self.$total)
                                                                ) {
                                                                    Image(systemName: !editIsOn ? "square.and.pencil" : "square.and.pencil")
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 15, height: 15)
                                                                        .foregroundColor(.black)
                                                                }
                                                                .onAppear() {
                                                                    self.refresh.toggle()
                                                                }
                                                                Button(action: {
                                                                    total -= food.wrappedValue.Price
                                                                    self.deleteFoodFromName(food: food.wrappedValue.Name)
                                                                    self.uncheckCategory(categoryItem: category)
                                                                    foodList.remove(at:foodList.firstIndex(of: food.wrappedValue)!)
                                                                    self.deleteIsOn.toggle()
                                                                }, label: {
                                                                    Image(systemName: !deleteIsOn ? "trash" : "trash")
                                                                        .resizable()
                                                                        .aspectRatio(contentMode: .fit)
                                                                        .frame(width: 15, height: 15)
                                                                        .foregroundColor(.black)
                                                                })
                                                            }
                                                            .frame(maxHeight: 40, alignment: .center)
                                                        } // FoodItem
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                    } // if food in category
                                                } // for food in category
                                            } //Foods
                                        } //Category
                                        .padding()
                                        .background(.white)
                                        .cornerRadius(15)
                                        .padding(.bottom, 5)
                                    }
                                } //for group in
                            }// ScrollView
                        } // else
                    } //Body
                    .frame(width: .infinity)
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 30)
                    Spacer()
                } // Screen
            } // ZStack
            .ignoresSafeArea(edges: .top)
        } // NavigationView
        .accentColor(.white)
//        .navigationViewStyle(.stack)
        .onAppear() {
            self.refresh.toggle()
        }
    }
}
