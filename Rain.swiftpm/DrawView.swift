//
//  DrawView.swift
//  Rain
//
//  Created by Alfonso Tarallo on 23/02/24.
//

import SwiftUI
import UIKit
import PencilKit


enum Mode {
    case drawing
    case erasing
}

struct DrawView: View {
    @EnvironmentObject var vm: RageViewModel
    @State var selectedColor: Color = .orange
    @State var selectedWidth: Double = 8.0
    @State var modeIndex: Int = 0
    @State var inkType: PKInkingTool.InkType = .marker
    
    var mode: Mode {
        switch modeIndex {
        case 0:
            return .drawing
        case 1:
            return .erasing
        default:
            return .drawing
        }
    }
    
    var body: some View {
        VStack {
            CanvasView(canvas: $vm.canvas, selectedColor: $selectedColor, selectedWidth: $selectedWidth, modeIndex: $modeIndex, inkType: $inkType)
            HStack(spacing: 32) {
                ColorPicker(selection: $selectedColor, label: {
                    EmptyView()
                })
                Slider(value: $selectedWidth, in: 5.0...50.0, step: 1.0, label: {
                }, minimumValueLabel: {
                    Label("", systemImage: "scribble")
                }, maximumValueLabel: {
                    Label("", systemImage: "scribble.variable")
                }) { _ in
                }
                .frame(minWidth: 300)
                Menu {
                    Button(action: {
                        inkType = .pencil
                    }, label: {
                        Label("Pencil", systemImage: "\(inkType == .pencil ? "checkmark.circle.fill" : "applepencil.and.scribble")")
                    })
                    Button(action: {
                        inkType = .pen
                    }, label: {
                        Label("Pen", systemImage: "\(inkType == .pen ? "checkmark.circle.fill" : "pencil.line")")
                    })
                    Button(action: {
                        inkType = .marker
                    }, label: {
                        Label("Marker", systemImage: "\(inkType == .marker ? "checkmark.circle.fill" : "pencil.and.scribble")")
                    })
                } label: {
                    Image(systemName: "pencil.tip")
                }
                
                Picker("", selection: $modeIndex) {
                    Image(systemName: "pencil").tag(0)
                    Image(systemName: "eraser").tag(1)
                }
                .pickerStyle(.segmented)
                .frame(minWidth: 150)
            }
            .padding(.trailing, 64)
            .padding(.top)
            
        }
        .padding()
        .onChange(of: modeIndex, perform: { _ in
        })
        .onAppear() {
            UISlider.appearance().setThumbImage(UIImage(named: "clear"), for: .normal)
        }
    }
    
}


#Preview {
    DrawView()
}




struct CanvasView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var selectedColor: Color
    @Binding var selectedWidth: Double
    @Binding var modeIndex: Int
    @Binding var inkType: PKInkingTool.InkType
    
    var ink: PKInkingTool {
        let color = PKInkingTool.convertColor(UIColor(selectedColor), from: .dark, to: .light)
        return PKInkingTool(inkType, color: color, width: selectedWidth)
    }
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.backgroundColor = .clear
        
        canvas.tool = modeIndex == 0 ? ink : eraser
        
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        uiView.tool = modeIndex == 0 ? ink : eraser
        
    }
}
