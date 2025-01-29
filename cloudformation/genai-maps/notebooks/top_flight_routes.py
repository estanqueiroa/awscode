import folium
from folium import plugins
import pandas as pd

# Data for top 10 busiest flight routes (2023-2024 data)
routes_data = {
    'rank': range(1, 11),
    'route': [
        'Jeju-Seoul Gimpo',
        'Hong Kong-Taipei',
        'Dubai-Riyadh',
        'Seoul Gimpo-Busan',
        'Tokyo Haneda-Sapporo',
        'Melbourne-Sydney',
        'Delhi-Mumbai',
        'Singapore-Jakarta',
        'Bangkok-Singapore',
        'Tokyo Haneda-Fukuoka'
    ],
    'airline': [
        'Korean Air/Asiana',
        'Cathay Pacific/China Airlines',
        'Emirates/Saudia',
        'Korean Air/Asiana',
        'JAL/ANA',
        'Qantas/Virgin Australia',
        'Air India/IndiGo',
        'Singapore Airlines/Garuda',
        'Thai Airways/Singapore Airlines',
        'JAL/ANA'
    ],
    'passengers_millions': [
        14.8,
        7.8,
        7.3,
        7.0,
        6.9,
        6.8,
        6.5,
        6.4,
        6.2,
        6.1
    ],
    'from_lat': [33.5007, 22.3080, 25.2532, 37.5585, 35.5494, -37.8136, 28.5562, 1.3501, 13.6900, 35.5494],
    'from_lon': [126.5288, 114.1701, 55.3657, 126.7902, 139.7798, 144.9631, 77.1000, 103.9940, 100.7501, 139.7798],
    'to_lat': [37.5585, 25.0797, 24.7136, 35.1796, 43.1168, -33.9399, 19.0898, -6.1275, 1.3501, 33.5902],
    'to_lon': [126.7902, 121.2342, 46.6753, 128.9380, 141.3815, 151.1753, 72.8680, 106.6537, 103.9940, 130.4515]
}

df = pd.DataFrame(routes_data)

# Create a map centered on a middle point
m = folium.Map(location=[30, 120], zoom_start=3, tiles='CartoDB positron')

# Add flight routes and markers
for idx, row in df.iterrows():
    # Create coordinates list for the route line
    coordinates = [[row['from_lat'], row['from_lon']], 
                  [row['to_lat'], row['to_lon']]]
    
    # Add route line with arrow
    plugins.AntPath(
        locations=coordinates,
        weight=2,
        color='red' if row['rank'] <= 3 else 'blue',
        popup=f"Route #{row['rank']}: {row['route']}"
    ).add_to(m)
    
    # Create popup content
    popup_content = f"""
    <div style="font-family: Arial; padding: 5px;">
        <h3 style="color: #2c3e50; margin-bottom: 5px;">#{row['rank']} - {row['route']}</h3>
        <div style="background-color: #f8f9fa; padding: 10px; border-radius: 5px;">
            <p style="margin: 5px 0;"><b>✈️ Airlines:</b> {row['airline']}</p>
            <p style="margin: 5px 0;"><b>👥 Annual Passengers:</b> {row['passengers_millions']} million</p>
            <p style="margin: 5px 0;"><b>🏆 Rank:</b> #{row['rank']}</p>
        </div>
    </div>
    """
    
    # Add markers for departure and arrival airports
    folium.CircleMarker(
        location=[row['from_lat'], row['from_lon']],
        radius=6,
        color='red' if row['rank'] <= 3 else 'blue',
        fill=True,
        popup=folium.Popup(popup_content, max_width=300),
        tooltip=f"From: {row['route'].split('-')[0]}"
    ).add_to(m)
    
    folium.CircleMarker(
        location=[row['to_lat'], row['to_lon']],
        radius=6,
        color='red' if row['rank'] <= 3 else 'blue',
        fill=True,
        popup=folium.Popup(popup_content, max_width=300),
        tooltip=f"To: {row['route'].split('-')[1]}"
    ).add_to(m)

# Add title
title_html = '''
<div style="position: fixed; 
            top: 10px; left: 50px; 
            width: 350px; 
            background-color: white; 
            border-radius: 10px;
            border: 2px solid grey; 
            z-index: 9999; 
            padding: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);">
    <h3 style="margin: 0; color: #2c3e50; text-align: center;">
        Top 10 Busiest Flight Routes Worldwide
    </h3>
    <p style="margin: 5px 0 0; font-size: 12px; color: #666; text-align: center;">
        Click on markers or routes for details
    </p>
</div>
'''
m.get_root().html.add_child(folium.Element(title_html))

# Add legend
legend_html = '''
<div style="position: fixed; 
            bottom: 50px; right: 50px; 
            width: 150px;
            background-color: white;
            border-radius: 10px;
            border: 2px solid grey;
            z-index: 9999;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);">
    <p style="margin: 0; color: #2c3e50;">
        <span style="color: red;">●</span> Top 3 Routes<br>
        <span style="color: blue;">●</span> Other Routes
    </p>
</div>
'''
m.get_root().html.add_child(folium.Element(legend_html))

# Save the map
m.save('top_flight_routes.html')

print("Map has been created as 'top_flight_routes.html'")
