package model 
{
	import common.Assets;
	import hex.terrain.Types;
	import observatory.DataTypes;
	import observatory.properties.InstrumentProperties;
	import data.DataSample

	/**
	 * ...
	 * @author Lambwatt
	 */
	public class GameTables 
	{
		public static var boringDataSampleCollection:Object = new Object;
		boringDataSampleCollection[DataTypes.VIDEO] = new Vector.< DataSample>;
		boringDataSampleCollection[DataTypes.AUDIO] = new Vector.< DataSample>;
		boringDataSampleCollection[DataTypes.CTD_DATA] = new Vector.< DataSample>;
		boringDataSampleCollection[DataTypes.PROFILES] = new Vector.< DataSample>;
		
		boringDataSampleCollection[DataTypes.VIDEO].push(new DataSample(Assets.IMG_VIDEOBORING,"B"));
		
		boringDataSampleCollection[DataTypes.AUDIO].push(new DataSample(Assets.IMG_HYDROPHONEUNIDENTIFIED,"B"));
		
		boringDataSampleCollection[DataTypes.CTD_DATA].push(new DataSample(Assets.IMG_CTDTEMPERATURE,"B"));
		boringDataSampleCollection[DataTypes.CTD_DATA].push(new DataSample(Assets.IMG_CTDTIDES_PRESSURE,"B"));
		boringDataSampleCollection[DataTypes.CTD_DATA].push(new DataSample(Assets.IMG_CTDSTORM_TEMP_SALINITY,"B"));
		
		boringDataSampleCollection[DataTypes.PROFILES].push(new DataSample(Assets.IMG_RDIADCP150WH8497_20130321T225136180Z_1D726_SCALAR,"B"));
		boringDataSampleCollection[DataTypes.PROFILES].push(new DataSample(Assets.IMG_RDIADCP150WH8497_20130321T225136180Z_1D726_UVWBS,"B"));
		
		public static var interestingDataSampleCollection:Object = new Object;
		interestingDataSampleCollection[DataTypes.VIDEO]=new Vector.< DataSample>;
		interestingDataSampleCollection[DataTypes.AUDIO]=new Vector.< DataSample>;
		interestingDataSampleCollection[DataTypes.CTD_DATA]=new Vector.< DataSample>;
		interestingDataSampleCollection[DataTypes.PROFILES]=new Vector.< DataSample>;
		
		interestingDataSampleCollection[DataTypes.VIDEO].push(new DataSample(Assets.IMG_VIDEOCRABSNAIL, "I"));
		interestingDataSampleCollection[DataTypes.VIDEO].push(new DataSample(Assets.IMG_VIDEOSABLEFISHHAGFISH,"I"));
		
		interestingDataSampleCollection[DataTypes.AUDIO].push(new DataSample(Assets.IMG_HYDROPHONEEARTHQUAKE,"I"));
		interestingDataSampleCollection[DataTypes.AUDIO].push(new DataSample(Assets.IMG_HYDROPHONESHIPPING,"I"));
		interestingDataSampleCollection[DataTypes.AUDIO].push(new DataSample(Assets.IMG_HYDROPHONEWHALES,"I"));
		
		interestingDataSampleCollection[DataTypes.CTD_DATA].push(new DataSample(Assets.IMG_CTDTSUNAMI_PRESSURE,"I"));
		
		interestingDataSampleCollection[DataTypes.PROFILES].push(new DataSample(Assets.IMG_RDIADCP150WH8497_20130320T000000330Z_1D726_SCALAR,"I"));
		interestingDataSampleCollection[DataTypes.PROFILES].push(new DataSample(Assets.IMG_RDIADCP150WH8497_20130320T000000330Z_1D726_UVWBS,"I"));
		
		// Ugggh.
		// I would love to make a class for this - InstrumentPropertyList?
		public static var instruments:Vector.<InstrumentProperties> = new Vector.<InstrumentProperties>;
		instruments.push(

			InstrumentProperties.describe("Node")
				.displayDescription("A node is a central hub of communication \nbetween NEPTUNE instruments.")
				.image(Assets.IMG_NODE)
				.storeImage(Assets.IMG_STORE_NODE)
				.isNode
				.costs(500000)
				.finish(),
				
			InstrumentProperties.describe("Hydrophone")
				.displayDescription("Hydrophones capture audio data.\n Neat!")
				.dataDescription("This is just audio data. \nNot that there's anything wrong \nwith that.")
				.interestingDataDescription("You're capturing some interesting data for great science!")
				.image(Assets.IMG_HYDROPHONE)
				.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
				.producesDataOnAllTerrain
				.produces(DataTypes.AUDIO)
				.costs(50000)
				.dataValue(2)
				.finish(),
				
			InstrumentProperties.describe("CTD")
				.displayDescription("A CTD!")
				.dataDescription("CTDs capture conductivity, temperature, and depth.")
				.interestingDataDescription("Oh my! Look at that huge drop in depth and temperature!")
				.image(Assets.IMG_CTD)
				.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
				.producesDataOnAllTerrain
				.produces(DataTypes.CTD_DATA)
				.costs(100000)
				.dataValue(4)
				.finish(),
				
			InstrumentProperties.describe("Camera")
				.displayDescription("Takes video of things under the ocean.")
				.dataDescription("High definition video streams \navailable 24/7 on the Internet.")
				.interestingDataDescription("What is going on in that video stream!?")
				.image(Assets.IMG_CAMERASPRITE)
				.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
				.producesDataOnAllTerrain
				.produces(DataTypes.VIDEO)
				.costs(200000)
				.dataValue(8)
				.finish(),
				
			InstrumentProperties.describe("ADCP")
				.displayDescription("Acoustic doppler current profiler")
				.dataDescription("similar to a sonar, attempting to measure\n water current velocities over a depth\n range using the Doppler effect of sound\n waves scattered back from \nparticles within the water column")
				.interestingDataDescription("Check out that effect! So doppler!")
				.image(Assets.IMG_ADCP)
				.storeImage(Assets.IMG_INSTRUMENT_IMAGE)
				.producesDataOnAllTerrain
				.produces(DataTypes.PROFILES)
				.costs(400000)
				.dataValue(10)
				.finish()
		);
		
		public static function instrumentIDByName(name:String):uint {
			
			name = name.toLowerCase();
			
			// TODO: Think about why these things aren't keyed by name anyway
			for (var id:int = 0; id < instruments.length; ++id) {
				
				if (instruments[id].name.toLowerCase() == name) return id;
			}
			
			throw new Error("Unknown instrument name: " + name);
		}
		
		public static function instrumentByName(name:String):InstrumentProperties {
			
			return instruments[instrumentIDByName(name)];
		}
	}

}
