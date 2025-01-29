import folium
from folium import plugins
import pandas as pd

# Data for top 10 busiest flight routes in the Americas (2023-2024 approximate data)
routes_data = {
    'rank': range(1, 11),
    'route': [
        'New York-Los Angeles',
        'Los Angeles-San Francisco',
        'New York-Miami',
        'New York-Chicago',
        'São Paulo-Rio de Janeiro',
        'Los Angeles-Las Vegas',
        'Boston-Washington DC',
        'Orlando-Atlanta',
        'Mexico City-Cancun',
        'Vancouver-Toronto'
    ],
    'airline': [
        'American/Delta/United',
        'United/Southwest/Alaska',
        'American/Delta',
        'American/United',
        'LATAM/Gol',
        'Southwest/American',
        'American/JetBlue',
        'Delta/Southwest',
        'Aeroméxico/Volaris',
        'Air Canada/WestJet'
    ],
    'passengers_millions': [
        4.0,
        3.7,
        3.5,
        3.3,
        3.1,
        3.0,
        2.8,
        2.7,
        2.6,
        2.5
    ],
    'from_lat': [40.6413, 33.9416, 40.6413, 40.6413, -23.6273, 33.9416, 42.3656, 28.4312, 19.4361, 49.1967],
    'from_lon': [-73.7781, -118.4085, -73.7781, -73.7781, -46.6566, -118.4085, -71.0096, -81.3081, -99.0719, -123.1815],
    'to_lat': [33.9416, 37.6188, 25.7933, 41.9742, -22.9068, 36.0840, 38.9072, 33.6407, 21.0365, 43.6777],
    'to_lon': [-118.4085, -122.3754, -80.2906, -87.9073, -43.1729, -115.1537, -77.0369, -84.4277, -86.8771, -79.6248]
}

df = pd.DataFrame(routes_data)

# Create a map centered on the Americas
m = folium.Map(location=[23, -100], zoom_start=3, tiles='CartoDB positron')

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
        Top 10 Busiest Flight Routes in the Americas
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
m.save('top_americas_flight_routes.html')

print("Map has been created as 'top_americas_flight_routes.html'")
