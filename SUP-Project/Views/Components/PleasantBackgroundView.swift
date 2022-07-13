//
//  RoadView.swift
//  SUP-Project
//
//  Created by Eric Internicola on 7/3/22.
//

import SwiftUI

struct PleasantBackgroundView: View {
    var body: some View {
        ZStack {
            Color.gray

            Image("rmnp-lake")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.3)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct PleasantBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        PleasantBackgroundView()
    }
}
