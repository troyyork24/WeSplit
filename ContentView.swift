//
//  ContentView.swift
//  WeSplit
//
//  Created by Troy York on 2/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
  
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
  
    var body: some View {
       
        NavigationView{
               
        Form {
           
                
            Section{
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
                TextField("Number of people", text: $numberOfPeople)
                    .keyboardType(.decimalPad)
                }

            
            Section(header: Text("How much do you want to tip?")){
                Picker("Tip Percentage", selection: $tipPercentage){
                    ForEach(0..<tipPercentages.count){
                        Text("\(tipPercentages[$0])")
                    }

                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("Amount per person")){
                Text("$\(totalPerPerson, specifier: "%.2f")")
            }
            Section(header: Text("Final Group Bill Total")){
                Text("$\((Double(numberOfPeople) ?? 1) * totalPerPerson, specifier: "%.2f")")
                    .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red: .primary)
            }
        }
        .navigationBarTitle("WeSplit")

        }
        }
}

//MARK: Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
