import folium
from folium import plugins
import pandas as pd
import random

# Data for top 10 busiest flight routes in South America (2023-2024 approximate data)
routes_data = {
    'rank': range(1, 11),
    'route': [
        'São Paulo-Rio de Janeiro',
        'São Paulo-Brasília',
        'Buenos Aires-Santiago',
        'Lima-Cusco',
        'São Paulo-Porto Alegre',
        'Bogotá-Medellín',
        'Santiago-Lima',
        'São Paulo-Salvador',
        'Buenos Aires-Córdoba',
        'Rio de Janeiro-Salvador'
    ],
    'airline': [
        'LATAM/Gol/Azul',
        'LATAM/Gol',
        'LATAM/Aerolíneas Argentinas',
        'LATAM Peru/Avianca',
        'Gol/LATAM',
        'Avianca/LATAM',
        'LATAM/Sky/JetSMART',
        'Gol/LATAM/Azul',
        'Aerolíneas Argentinas/JetSMART',
        'Gol/LATAM/Azul'
    ],
    'passengers_millions': [
        3.2, 2.8, 2.5, 2.3, 2.1, 2.0, 1.9, 1.8, 1.7, 1.6
    ],
    'from_lat': [-23.6273, -23.6273, -34.6037, -12.0464, -23.6273, 4.7010, -33.4489, -23.6273, -34.6037, -22.9068],
    'from_lon': [-46.6566, -46.6566, -58.3816, -77.0428, -46.6566, -74.1469, -70.6693, -46.6566, -58.3816, -43.1729],
    'to_lat': [-22.9068, -15.8697, -33.4489, -13.5319, -30.0346, 6.1744, -12.0464, -12.9714, -31.4201, -12.9714],
    'to_lon': [-43.1729, -47.9172, -70.6693, -71.9675, -51.2177, -75.4273, -77.0428, -38.5014, -64.1888, -38.5014]
}

df = pd.DataFrame(routes_data)

# Create a map centered on South America
m = folium.Map(location=[-15, -60], zoom_start=3, tiles='CartoDB positron')

# Create MarkerClusters for departure and arrival
departure_cluster = plugins.MarkerCluster(name="Departure Airports")
arrival_cluster = plugins.MarkerCluster(name="Arrival Airports")

# Function to slightly adjust coordinates for overlapping markers
def jitter_coordinates(lat, lon):
    return lat + random.uniform(-0.1, 0.1), lon + random.uniform(-0.1, 0.1)

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
        popup=f"Route #{row['rank']}: {row['route']}",
        delay=1000,
        dash_array=[10, 20],
        pulse_color='#FFF'
    ).add_to(m)
    
    # Create popup content
    popup_content = f"""
    <div style="font-family: Arial; padding: 5px;">
        <h3 style="color: #2c3e50; margin-bottom: 5px;">#{row['rank']} - {row['route']}</h3>
        <div style="background-color: #f8f9fa; padding: 10px; border-radius: 5px;">
            <p style="margin: 5px 0;"><b>✈️ Airlines:</b> {row['airline']}</p>
            <p style="margin: 5px 0;"><b>👥 Annual Passengers:</b> {row['passengers_millions']} million</p>
            <p style="margin: 5px 0;"><b>🏆 Rank:</b> #{row['rank']}</p>
            <p style="margin: 5px 0;"><b>🛫 Route Status:</b> {
                "Premium Route" if row['rank'] <= 3 
                else "Major Route" if row['rank'] <= 6 
                else "Regular Route"
            }</p>
        </div>
    </div>
    """
    
    # Add markers for departure airports with jittered coordinates
    jittered_from_lat, jittered_from_lon = jitter_coordinates(row['from_lat'], row['from_lon'])
    folium.Marker(
        location=[jittered_from_lat, jittered_from_lon],
        icon=folium.Icon(color='red' if row['rank'] <= 3 else 'blue', icon='plane-departure', prefix='fa'),
        popup=folium.Popup(popup_content, max_width=300),
        tooltip=f"From: {row['route'].split('-')[0]}"
    ).add_to(departure_cluster)
    
    # Add markers for arrival airports with jittered coordinates
    jittered_to_lat, jittered_to_lon = jitter_coordinates(row['to_lat'], row['to_lon'])
    folium.Marker(
        location=[jittered_to_lat, jittered_to_lon],
        icon=folium.Icon(color='red' if row['rank'] <= 3 else 'blue', icon='plane-arrival', prefix='fa'),
        popup=folium.Popup(popup_content, max_width=300),
        tooltip=f"To: {row['route'].split('-')[1]}"
    ).add_to(arrival_cluster)

# Add clusters to map
departure_cluster.add_to(m)
arrival_cluster.add_to(m)

# Add layer control
folium.LayerControl().add_to(m)

# Add title
title_html = '''
<div style="position: fixed; 
            top: 10px; left: 50px; 
            width: 380px; 
            background-color: white; 
            border-radius: 10px;
            border: 2px solid grey; 
            z-index: 9999; 
            padding: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);">
    <h3 style="margin: 0; color: #2c3e50; text-align: center;">
        Top 10 Busiest Flight Routes in South America
    </h3>
    <p style="margin: 5px 0 0; font-size: 12px; color: #666; text-align: center;">
        Click on markers or routes for detailed information
    </p>
</div>
'''
m.get_root().html.add_child(folium.Element(title_html))

# Add legend
legend_html = '''
<div style="position: fixed; 
            bottom: 50px; right: 50px; 
            width: 180px;
            background-color: white;
            border-radius: 10px;
            border: 2px solid grey;
            z-index: 9999;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);">
    <h4 style="margin: 0 0 5px 0; color: #2c3e50;">Route Categories</h4>
    <p style="margin: 0; color: #2c3e50;">
        <span style="color: red;">●</span> Premium Routes (Top 3)<br>
        <span style="color: blue;">●</span> Major Routes (4-10)
    </p>
</div>
'''
m.get_root().html.add_child(folium.Element(legend_html))

# Save the map
m.save('top_south_america_flight_routes.html')

print("Map has been created as 'top_south_america_flight_routes.html'")
