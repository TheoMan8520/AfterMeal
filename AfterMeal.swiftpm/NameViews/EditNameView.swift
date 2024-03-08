import SwiftUI

struct EditNameView: View {
    @Binding var nameItem: NameClass
    @Binding var groupList: [GroupCheck]
    
    var foodList: [FoodClass]
    @State var foodListCheck: [FoodCheck] = []
    @State var categoryList: [CategoryEnum] = []
    @State var categoryListCheck: [CategoryCheck] = []
    
    @State var Photo: String = ""
    @State var Name: String = ""
    @State var Group: GroupEnum = GroupEnum.Nogroup
    @State var OldGroup: GroupEnum = GroupEnum.Nogroup
    
    @State var refresh = false
    @State var eatAll = false
    @State var eatCount: Int = 0
    
    @Environment(\.dismiss) var dismiss
    
    func useEffect() -> Void {
        let foodRef = nameItem.Foods
        foodList.forEach { food in
            var check = false
            if(foodRef.contains(food.Name)){
                check = true
            }
            foodListCheck.append(FoodCheck(Name: food.Name, IsCheck: check, Category: food.Category))
            
            let category = food.Category
            if(!categoryList.contains(category)) {
                var count = 0
                categoryList.append(category)
                if(foodRef.contains(food.Name)){
                    eatCount += 1
                    count += 1
                }
                categoryListCheck.append(CategoryCheck(Name: category, count: count, len: 1, IsCheck: false))
            } else {
                categoryListCheck.forEach { categoryItem in
                    if(categoryItem.Name == category) {
                        categoryItem.len += 1
                        if(foodRef.contains(food.Name)){
                            eatCount += 1
                            categoryItem.count += 1
                        }
                    }
                }
            }
        }
        categoryListCheck.forEach { categoryItem in
            if(categoryItem.count == categoryItem.len) {
                categoryItem.IsCheck = true
            }
        }
        if (eatCount == foodListCheck.count) {
            eatAll = true
        }
        Photo = nameItem.Photo
        Name = nameItem.Name
        Group = nameItem.Group
        OldGroup = nameItem.Group
    }
    
    func applyAll() -> Void {
        self.eatAll.toggle()
        foodListCheck.forEach { food in
            food.IsCheck = eatAll ? true : false
        }
        categoryListCheck.forEach { category in
            category.IsCheck = eatAll ? true : false
            category.count = eatAll ? category.len : 0
        }
        self.eatCount = eatAll ? foodListCheck.count : 0
        self.refresh.toggle()
    }
    
    func changePhoto() -> Void {
        if(Photo == "👤") {
            Photo = "👱🏻‍♂️"
        } else if (Photo == "👱🏻‍♂️") {
            Photo = "👩🏻‍🦰"
        } else if (Photo == "👩🏻‍🦰") {
            Photo = "👴🏻"
        } else if (Photo == "👴🏻") {
            Photo = "🧓🏻"
        } else if (Photo == "🧓🏻") {
            Photo = "🧝🏻‍♂️"
        } else if (Photo == "🧝🏻‍♂️") {
            Photo = "🧝🏻‍♀️"
        } else if (Photo == "🧝🏻‍♀️") {
            Photo = "🧙🏻‍♂️"
        } else if (Photo == "🧙🏻‍♂️") {
            Photo = "🧙🏻‍♀️"
        } else if (Photo == "🧙🏻‍♀️") {
            Photo = "🧜🏻‍♀️"
        } else if (Photo == "🧜🏻‍♀️") {
            Photo = "🧜🏻‍♂️"
        } else if (Photo == "🧜🏻‍♂️") {
            Photo = "🧚🏻‍♀️"
        } else if (Photo == "🧚🏻‍♀️") {
            Photo = "🧚🏻‍♂️"
        } else if (Photo == "🧚🏻‍♀️") {
            Photo = "👤"
        }
    }
    
    var body: some View {
        ZStack { // ZStack
            Color.init(red: 245/255, green: 245/255, blue: 245/255)
            VStack { // Screen
                VStack { // All top
                    HStack {} // above island
                        .frame(maxWidth: .infinity, maxHeight: 25)
                        .background(.blue)
                    HStack { // Header
                        HStack{} //adjust
                            .frame(width: 40.0, height: 40.0)
                            .padding(.leading, 40)
                        HStack { // middle
                            Text("Edit Name")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        } // middle
                            .frame(maxWidth: .infinity)
                        HStack{} // adjust / icon
                            .frame(width: 40.0, height: 40.0)
                            .padding(.leading, 40)
                    } // Header
                        .frame(maxWidth: .infinity)
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                        .padding([.leading, .trailing])
                        .background(.blue)
    //                    .shadow(color: .gray, radius: 5, x: 0, y: 2)
                } // All top
                VStack(spacing: 10) { //form
                    Button (action: {
                        self.changePhoto()
                    }, label: {
                        Text(Photo)
                            .font(.system(size: 80))
                            .frame(maxWidth: 100, maxHeight: 100, alignment: .center)
                            .padding()
                            .background(
                                Circle()
                                    .fill(
                                        .shadow(.inner(color: .gray.opacity(0.5), radius:5, x: 0, y: -5))
                                    )
                            )
                            .cornerRadius(100)
                            .shadow(color: .gray, radius: 5, x: 0, y: 2)
                    })
                    VStack(spacing: 10) { //Name
                        Text("Name")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("Name...", text: self.$Name)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .padding([.top, .bottom], 0)
                            .background(.white)
                            .accentColor(.blue)
                            .cornerRadius(10)
                    } // Name
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack(spacing: 10) { // Group
                        Text("Group")
                            .font(.system(size: 25))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Section {
                            Picker("", selection: $Group) {
                                Text("No group").tag(GroupEnum.Nogroup)
                                Text("Eat All").tag(GroupEnum.EatAll)
                                Text("Drinker").tag(GroupEnum.Drinker)
                                Text("Speacial List").tag(GroupEnum.SpecialList)
                                Text("Group 1").tag(GroupEnum.Group1)
                                Text("Group 2").tag(GroupEnum.Group2)
                                Text("Group 3").tag(GroupEnum.Group3)
                            }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .accentColor(.black)
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding([.top, .bottom], 10)
                            .background(.white)
                            .cornerRadius(10)
                    } // Group
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    HStack { //Apply all
                        Button(action: {
                            self.applyAll()
                        }, label: {
                            Image(systemName: !eatAll ? "circle" : "checkmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.red)
                        })
                        Text(refresh ? "Apply all" : "Apply all")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } //Apply all
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.top, 10)
                    ScrollView { // Categories
                        ForEach(self.$categoryListCheck, id:\.self) { $category in // for category in list
                            VStack { // Category
                                HStack { // Category header
                                    Text(categoryEnumToString(category:category.Name))
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    HStack { //Apply all in group
                                        Button(action: {
                                            $category.wrappedValue.IsCheck.toggle()
                                            if(!$category.wrappedValue.IsCheck) {
                                                $category.wrappedValue.count = 0
                                                eatAll = false
                                                foodListCheck.forEach { food in
                                                    if(food.Category == $category.wrappedValue.Name && food.IsCheck) {
                                                        self.eatCount -= 1
                                                        food.IsCheck = false
                                                    }
                                                }
                                            } else {
                                                $category.wrappedValue.count = $category.wrappedValue.len
                                                foodListCheck.forEach { food in
                                                    if(food.Category == $category.wrappedValue.Name && !food.IsCheck) {
                                                        self.eatCount += 1
                                                        food.IsCheck = true
                                                    }
                                                }
                                                if(self.eatCount == foodListCheck.count) {
                                                    eatAll = true
                                                }
                                            }
                                            self.refresh.toggle()
                                        }, label: {
                                            Image(systemName: !$category.wrappedValue.IsCheck ? "circle" : "checkmark.circle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(.orange)
                                        })
                                        Text("All in group")
                                            .font(.system(size: 20))
                                    } //Apply all in group
                                } // Category header
                                VStack { // Food list
                                    ForEach(self.$foodListCheck, id:\.self) { $food in // For food in list
                                        if ($food.wrappedValue.Category == $category.wrappedValue.Name) { // if food in category
                                            HStack { //Food Item
                                                Button(action: {
                                                    $food.wrappedValue.IsCheck.toggle()
                                                    if (!$food.wrappedValue.IsCheck) {
                                                        self.eatCount -= 1
                                                        $category.wrappedValue.count -= 1
                                                        self.eatAll = false
                                                        $category.wrappedValue.IsCheck = false
                                                    } else {
                                                        self.eatCount += 1
                                                        $category.wrappedValue.count += 1
                                                        if(self.eatCount == foodListCheck.count) {
                                                            eatAll = true
                                                        }
                                                        if ($category.wrappedValue.count == $category.wrappedValue.len) {
                                                            $category.wrappedValue.IsCheck = true
                                                        }
                                                    }
                                                    self.refresh.toggle()
                                                }, label: {
                                                    Image(systemName: !$food.wrappedValue.IsCheck ? "circle" : "checkmark.circle.fill")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 25, height: 25)
                                                        .foregroundColor(.blue)
                                                })
                                                Text(refresh ? "\($food.wrappedValue.Name)" : "\($food.wrappedValue.Name)")
                                                    .font(.system(size: 20))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            } //Food Item
                                            .frame(maxWidth: .infinity, alignment: .topLeading)
                                            .padding([.top, .bottom], 15)
                                            .padding(.leading, 15)
                                            .background(.white)
                                            .cornerRadius(15)
                                        } // if food in category
                                    } // For food in list
                                } // Food list
                            } // Category
                            .padding(.top, 20)
                        } // for category in list
                    } // Categories
                        .frame(width: .infinity)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    VStack(spacing: 10) { // Save
                        Button(action: {
                            var foods: [String] = []
                            var categories: [String] = []
                            foodListCheck.forEach { food in
                                if (food.IsCheck == true) {
                                    foods.append(food.Name)
                                }
                            }
                            categoryListCheck.forEach { category in
                                if (category.IsCheck) {
                                    categories.append(category.NameS)
                                }
                            }
                            if(Group != OldGroup) {
                                groupList.forEach { group in
                                    if (group.Name == Group) {
                                        group.IsCheck = true
                                        group.count += 1
                                    } else if (group.Name == OldGroup) {
                                        group.count -= 1
                                        if (group.count == 0) {
                                            group.IsCheck = false
                                        }
                                    }
                                }
                            }
                            nameItem = NameClass(Name: Name, Group: Group, Foods: foods, Categories: categories, EatAll: eatAll, Photo: Photo)
                            dismiss()
                        }, label: {
                            Text("Save")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .padding([.top, .bottom], 10)
                                .padding([.leading, .trailing], 25)
                                .background(.blue)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                        })
                    } // Save
                        .frame(width: .infinity)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } //form
                .frame(width: .infinity)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, 10)
                .padding([.leading, .trailing], 30)
//                .background(.green)
                Spacer()
            } // Screen
        } // ZStack
        .ignoresSafeArea(edges: .top)
        .onAppear() {
            self.useEffect()
        }
    }
}

//#Preview {
//    var theName: NameClass() = NameClass()
//    EditNameView(nameItem: theName)
//}
