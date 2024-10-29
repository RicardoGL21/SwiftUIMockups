import SwiftUI

struct EnhancedRocketEmojiView: View {
    @State private var rocketOffset = CGSize.zero
    @State private var flameOpacity = 0.0
    @State private var smokeOpacity = 0.0
    @State private var scale: CGFloat = 1.0

    var body: some View {
        ZStack {
            // Background
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ZStack {
                    // Smoke particles
                    ForEach(0..<15) { i in
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: CGFloat.random(in: 20...50), height: CGFloat.random(in: 20...50))
                            .offset(x: CGFloat.random(in: -100...100), y: CGFloat.random(in: 100...300))
                            .opacity(smokeOpacity)
                            .scaleEffect(scale)
                            .animation(
                                Animation.easeInOut(duration: 2)
                                    .repeatForever(autoreverses: false)
                                    .delay(Double(i) * 0.2),
                                value: scale
                            )
                    }

                    // Rocket emoji
                    Text("🚀")
                        .font(.system(size: 100)) // Rocket emoji
                        .offset(rocketOffset)
                        .scaleEffect(scale)
                        .animation(.easeInOut(duration: 1), value: rocketOffset)

                    // Rocket flame
                    FireShape()
                        .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .orange, .red]), startPoint: .top, endPoint: .bottom))
                        .frame(width: 30, height: 60)
                        .offset(y: 130)
                        .opacity(flameOpacity)
                        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: flameOpacity)
                }
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: false)) {
                rocketOffset = CGSize(width: 0, height: -600)
            }
            flameOpacity = 1.0
            smokeOpacity = 1.0
            scale = 0.8
        }
    }
}

struct FireShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY),
                          control: CGPoint(x: rect.minX - 10, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY),
                          control: CGPoint(x: rect.midX, y: rect.midY + 20))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY),
                          control: CGPoint(x: rect.maxX + 10, y: rect.midY))
        return path
    }
}

struct ContentView: View {
    var body: some View {
        EnhancedRocketEmojiView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
