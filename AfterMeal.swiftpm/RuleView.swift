import SwiftUI

struct RuleView: View {
    @Binding var vat: RuleClass
    @Binding var serviceCharge: RuleClass
    @Binding var discount: RuleClass
    @Binding var sponsor: RuleClass
    @Binding var currency: String
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @State var refresh: Bool = false
    
    var body: some View {
        ZStack { // ZStack
            Color.init(red: 245/255, green: 245/255, blue: 245/255) // background color
            VStack { // Screen
                VStack(spacing: 0) { // All top
                    HStack {} // above island
                        .frame(maxWidth: .infinity, maxHeight: 25)
                        .background(.green) // above island color
                    HStack { // Header
                        HStack{} //adjust
                            .frame(width: 40.0, height: 40.0, alignment: .trailing)
                            .padding(.leading, 20)
                        HStack { // middle
                            Text("Rules")
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
                        .background(.green) // header color
                } // All top
                VStack(spacing: 10) { // Body
                    HStack { //Vat
                        Button(action: {
                            $vat.wrappedValue.IsCheck.toggle()
                            self.refresh.toggle()
                        }, label: {
                            Image(systemName: !$vat.wrappedValue.IsCheck ? "circle" : "checkmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.green)
                        })
                        Text(refresh ? "Vat" : "Vat")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button(action: {
                            if($vat.wrappedValue.Value > 1) {
                                $vat.wrappedValue.Value -= 1
                                self.refresh.toggle()
                            }
                        }, label: {
                            Image(systemName: "minus.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.green)
                        })
                            .disabled(!vat.IsCheck)
                        Text("\(String(format: "%.0f", vat.Value)) %")
                            .font(.system(size: 20))
                            .frame(width: 50)
                        Button(action: {
                            if($vat.wrappedValue.Value < 20) {
                                $vat.wrappedValue.Value += 1
                                self.refresh.toggle()
                            }
                        }, label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.green)
                        })
                            .disabled(!vat.IsCheck)
                    } //Vat
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .foregroundColor(vat.IsCheck ? .black : .gray)
                        .padding([.leading, .trailing], 15)
                        .padding([.top, .bottom], 15)
                        .background(.white)
                        .cornerRadius(15)
                    HStack { // Service Charge
                        Button(action: {
                            $serviceCharge.wrappedValue.IsCheck.toggle()
                            self.refresh.toggle()
                        }, label: {
                            Image(systemName: !$serviceCharge.wrappedValue.IsCheck ? "circle" : "checkmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.green)
                        })
                        Text(refresh ? "Service Charge" : "Service Charge")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button(action: {
                            if($serviceCharge.wrappedValue.Value > 1) {
                                $serviceCharge.wrappedValue.Value -= 1
                                self.refresh.toggle()
                            }
                        }, label: {
                            Image(systemName: "minus.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.green)
                        })
                            .disabled(!serviceCharge.IsCheck)
                        Text("\(String(format: "%.0f", serviceCharge.Value)) %")
                            .font(.system(size: 20))
                            .frame(width: 50)
                        Button(action: {
                            if($serviceCharge.wrappedValue.Value < 20) {
                                $serviceCharge.wrappedValue.Value += 1
                                self.refresh.toggle()
                            }
                        }, label: {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.green)
                        })
                            .disabled(!serviceCharge.IsCheck)
                    } //Service Charge
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .foregroundColor(serviceCharge.IsCheck ? .black : .gray)
                        .padding([.leading, .trailing], 15)
                        .padding([.top, .bottom], 15)
                        .background(.white)
                        .cornerRadius(15)
                    Section {
                        Picker("", selection: $currency) {
                            Text("$").tag("$")
                            Text("฿").tag("฿")
                        }
                        .pickerStyle(.segmented)
                    }
                    HStack { //Discount
                        Button(action: {
                            $discount.wrappedValue.IsCheck.toggle()
                            self.refresh.toggle()
                        }, label: {
                            Image(systemName: !$discount.wrappedValue.IsCheck ? "circle" : "checkmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.green)
                        })
                        Text(refresh ? "Discount" : "Discount")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("0", value: $discount.Value, formatter: formatter)
                            .keyboardType(.numberPad)
                            .disabled(!discount.IsCheck)
                            .frame(maxWidth: 70)
                            .font(.system(size: 20))
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text(currency)
                            .font(.system(size: 20))
                            .padding(.leading, 15)
                    } //Discount
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .foregroundColor(discount.IsCheck ? .black : .gray)
                        .padding([.leading, .trailing], 15)
                        .padding([.top, .bottom], 15)
                        .background(.white)
                        .cornerRadius(15)
                    HStack { //Sponsor
                        Button(action: {
                            $sponsor.wrappedValue.IsCheck.toggle()
                            self.refresh.toggle()
                        }, label: {
                            Image(systemName: !$sponsor.wrappedValue.IsCheck ? "circle" : "checkmark.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.green)
                        })
                        Text(refresh ? "Sponsor" : "Sponsor")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("0", value: $sponsor.Value, formatter: formatter)
                            .keyboardType(.numberPad)
                            .disabled(!sponsor.IsCheck)
                            .frame(maxWidth: 70)
                            .font(.system(size: 20))
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text(currency)
                            .font(.system(size: 20))
                            .padding(.leading, 15)
                    } //Sponsor
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .foregroundColor(sponsor.IsCheck ? .black : .gray)
                        .padding([.leading, .trailing], 15)
                        .padding([.top, .bottom], 15)
                        .background(.white)
                        .cornerRadius(15)
                } //Body
                .frame(width: .infinity)
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, 10)
                .padding([.leading, .trailing], 30)
                Spacer()
            } // Screen
        } // ZStack
        .ignoresSafeArea(edges: .top)
        .onAppear() {
            self.refresh.toggle()
        }
    }
}
