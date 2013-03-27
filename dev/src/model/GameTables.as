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
		
		
		boringDataSampleCollection[DataTypes.VIDEO].push(new DataSample(Assets.IMG_VIDEOBORING,"No animals were recorded in this video."));
		
		
		boringDataSampleCollection[DataTypes.AUDIO].push(new DataSample(Assets.IMG_HYDROPHONEUNIDENTIFIED, "Scientists have not yet identified\n"+
																											"the sounds in this hydrophone\n"+
																											"recording."));
		
		
		boringDataSampleCollection[DataTypes.CTD_DATA].push(new DataSample(Assets.IMG_CTDTEMPERATURE, "The temperature recorded by the\n" + 
																										"CTD varies from 3.7-4.2 degrees C."));
		boringDataSampleCollection[DataTypes.CTD_DATA].push(new DataSample(Assets.IMG_CTDTIDES_PRESSURE, "The CTD pressure sensor records the\n"+
																											"tidal cycle."));

		
		
		boringDataSampleCollection[DataTypes.PROFILES].push(new DataSample(Assets.IMG_RDIADCP150WH8497_20130321T225136180Z_1D726_SCALAR,"B"));
		boringDataSampleCollection[DataTypes.PROFILES].push(new DataSample(Assets.IMG_RDIADCP150WH8497_20130321T225136180Z_1D726_UVWBS,"B"));
		
		public static var interestingDataSampleCollection:Object = new Object;
		interestingDataSampleCollection[DataTypes.VIDEO]=new Vector.< DataSample>;
		interestingDataSampleCollection[DataTypes.AUDIO]=new Vector.< DataSample>;
		interestingDataSampleCollection[DataTypes.CTD_DATA]=new Vector.< DataSample>;
		interestingDataSampleCollection[DataTypes.PROFILES]=new Vector.< DataSample>;
		
		
		interestingDataSampleCollection[DataTypes.VIDEO].push(new DataSample(Assets.IMG_VIDEOCRABSNAIL, "The video camera captured 3 crabs\n" +
																											"and a deep-sea snail."));
		interestingDataSampleCollection[DataTypes.VIDEO].push(new DataSample(Assets.IMG_VIDEOSABLEFISHHAGFISH,"Two sablefish, a hagfish and a\n"+
																												" gastropod visit the video camera."));
		
		interestingDataSampleCollection[DataTypes.AUDIO].push(new DataSample(Assets.IMG_HYDROPHONEEARTHQUAKE, "The low frequency rumble of an\n"+
																												"earthquake was recorded by the\n"+
																												"hydrophone."));
		interestingDataSampleCollection[DataTypes.AUDIO].push(new DataSample(Assets.IMG_HYDROPHONESHIPPING, "A ship with a distinctive whine in\n" +
																											"its engine was recorded."));
		interestingDataSampleCollection[DataTypes.AUDIO].push(new DataSample(Assets.IMG_HYDROPHONEWHALES,"The hydrophone recorded whale calls."));
		
		
		interestingDataSampleCollection[DataTypes.CTD_DATA].push(new DataSample(Assets.IMG_CTDTSUNAMI_PRESSURE, "The pressure sensor on the CTD has\n" +
																													"recorded the arrival of a tsunami."));
		
		interestingDataSampleCollection[DataTypes.CTD_DATA].push(new DataSample(Assets.IMG_CTDSTORM_TEMP_SALINITY, "The effects of a storm can be seen in\n"+
																												"the temperature and pressure sensors\n" + 
																												"on the CTD."));
		
		
		interestingDataSampleCollection[DataTypes.PROFILES].push(new DataSample(Assets.IMG_RDIADCP150WH8497_20130320T000000330Z_1D726_SCALAR,"I"));
		interestingDataSampleCollection[DataTypes.PROFILES].push(new DataSample(Assets.IMG_RDIADCP150WH8497_20130320T000000330Z_1D726_UVWBS,"I"));
		
		// Ugggh.
		// I would love to make a class for this - InstrumentPropertyList?
		public static var instruments:Vector.<InstrumentProperties> = new Vector.<InstrumentProperties>;
		instruments.push(

			InstrumentProperties.describe("Node")
				.displayDescription("A node is a central hub of communication\nbetween NEPTUNE instruments.  The cables\nfrom the nodes eventually lead back\nPort Alberni.")
				.image(Assets.IMG_NODE)
				.storeImage(Assets.IMG_STORE_NODE)
				.isNode
				.costs(500000)
				.finish(),
				
			InstrumentProperties.describe("Hydrophone")
				.displayDescription("Hydrophones capture audio data allowing us\n" +
									"to hear the deep ocean.\n")
				.dataDescription("This is just audio data. \nNot that there's anything wrong \nwith that.")
				.interestingDataDescription("You're capturing some interesting data for great science!")
				.image(Assets.IMG_HYDROPHONE)
				.storeImage(Assets.IMG_HYDROPHONE_IMAGE)
				.producesDataOnAllTerrain
				.produces(DataTypes.AUDIO)
				.costs(50000)
				.dataValue(2)
				.finish(),
				
			InstrumentProperties.describe("CTD")
				.displayDescription("CTDs capture conductivity, temperature, and depth.")
				.dataDescription("CTDs capture conductivity, temperature, and depth.")
				.interestingDataDescription("Oh my! Look at that huge drop in depth and temperature!")
				.image(Assets.IMG_CTD)
				.storeImage(Assets.IMG_CTD_IMAGE)
				.producesDataOnAllTerrain
				.produces(DataTypes.CTD_DATA)
				.costs(100000)
				.dataValue(4)
				.finish(),
				
			InstrumentProperties.describe("Camera")
				.displayDescription("Takes video of things under the ocean.")
				.dataDescription("High definition video streams\navailable 24/7 on the Internet.")
				.interestingDataDescription("What is going on in that video stream!?")
				.image(Assets.IMG_CAMERASPRITE)
				.storeImage(Assets.IMG_CAMERA_IMAGE)
				.producesDataOnAllTerrain
				.produces(DataTypes.VIDEO)
				.costs(200000)
				.dataValue(8)
				.finish(),
				
			InstrumentProperties.describe("ADCP")
				.displayDescription("An Acoustic doppler current profiler is similar\nto a sonar, attempting to measure\nwater current velocities over a depth range\nusing the Doppler effect of sound\n waves scattered back from particles\nwithin the water column.")
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
