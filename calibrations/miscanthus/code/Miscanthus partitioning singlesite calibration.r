library(BioCro) #using develop branch
library(MiscanthusBML)
#Yufeng He: Dec 12, 2022 and adapted by Kacey Estrella Nov 2025

run_cwrfsoilwater=FALSE
# parameters and weather inputs

miscanthus_x_giganteus <- list(
  direct_modules = list(
    "BioCro:format_time",
    stomata_water_stress = "BioCro:stomata_water_stress_linear",
    "BioCro:leaf_water_stress_exponential",
    specific_leaf_area = "BioCro:sla_linear",
    "BioCro:parameter_calculator",
    "BioCro:soil_evaporation",
    solar_coordinates = "BioCro:solar_position_michalsky",
    "BioCro:height_from_lai",
    "BioCro:canopy_gbw_thornley",
    "BioCro:stefan_boltzmann_longwave",
    canopy_photosynthesis = "BioCro:c4_canopy",
    partitioning_coefficients = "MiscanthusBML:partitioning_coefficient_logistic",
    partitioning_growth_calculator = "BioCro:partitioning_growth_calculator",
    "BioCro:carbon_assimilation_to_biomass",
    "BioCro:thermal_time_development_rate_calculator",
    "MiscanthusBML:delta_TT"
  ),
  differential_modules = list(
    senescence = "MiscanthusBML:miscanthus_senescence",
    "BioCro:development_index",
    "BioCro:partitioning_growth",
    thermal_time = "BioCro:thermal_time_trilinear",
    soil_profile = "BioCro:two_layer_soil_profile"
  ),
  ode_solver = list(
    type = 'homemade_euler',
    output_step_size = 1.0,
    adaptive_rel_error_tol = 1e-5,
    adaptive_abs_error_tol = 1e-5,
    adaptive_max_steps = 200
  ),
  initial_values = list(
    cws1                        = 0.32,
    cws2                        = 0.32,
    DVI                         = -1,
    Grain                       = 0,
    Shell                       = 0,
    Leaf                        = 0, 
    LeafLitter                  = 0,
    leaf_senescence_index       = 0,
    Rhizome                     = 24.1,
    RhizomeLitter               = 0,
    rhizome_senescence_index    = 0,
    Root                        = 0,
    RootLitter                  = 0,
    root_senescence_index       = 0,
    soil_water_content          = 0.32,
    Stem                        = 0, 
    StemLitter                  = 0,
    stem_senescence_index       = 0,
    TTc                         = 0
  ),
  parameters = list(
    alpha1                      = 0.04,
    alphab1                     = 0,
    atmospheric_pressure        = 101325,
    atmospheric_scattering      = 0.3,
    atmospheric_transmittance   = 0.6, # Campbell and Norman, An Introduction to Environmental Biophysics, 2nd Edition, Pg 173
    alphaShell                  = 0,
    betaShell                   = 0,
    b0                          = 0.08,
    b1                          = 3,
    beta                        = 0.93,
    Catm                        = 400,
    chil                        = 1,
    dry_biomass_per_carbon      = 30.026, # g CHO / mol C (glucose)
    emissivity_sky              = 1,
    grc_grain                   = 0.0,
    grc_leaf                    = 0.02,
    grc_rhizome                 = 0.03,
    grc_root                    = 0.03,
    grc_shell                   = 0.0,
    grc_stem                    = 0.02,
    growth_respiration_fraction = 0.0,
    Gs_min                      = 1e-3,
    heightf                     = 3, 
    hydrDist                    = 0,
    iSp                         = 1.7,
    k_diffuse                   = 0.1,
    kparm                       = 0.7,
    kStem_emr                   = 0.609721,
    kLeaf_emr.                  = 0.269631,
    kRhizome_emr_DVI            = 0,
    kpLN                        = 0.2,
    lai_max                     = 6,
    lat                         = 40,
    leaf_reflectance_nir        = 0.38, # Corn values from Table 7-1 from Norman & Arkebauer (1991) https://doi.org/10.2134/agronmonogr31.c7
    leaf_reflectance_par        = 0.09, # Corn values from Table 7-1 from Norman & Arkebauer (1991) https://doi.org/10.2134/agronmonogr31.c7
    leaf_transmittance_nir      = 0.45, # Corn values from Table 7-1 from Norman & Arkebauer (1991) https://doi.org/10.2134/agronmonogr31.c7
    leaf_transmittance_par      = 0.04, # Corn values from Table 7-1 from Norman & Arkebauer (1991) https://doi.org/10.2134/agronmonogr31.c7
    leaf_turnover_rate          = 0.0000174,
    LeafN                       = 2,
    LeafN_0                     = 2,
    leafwidth                   = 0.04,
    lnfun                       = 0,
    longitude                   = -88,
    lowerT                      = 3,
    min_gbw_canopy              = 0.005,
    nalphab0                    = 0.02367,
    nalphab1                    = 0.000488,
    nileafn                     = 85,
    nkln                        = 0.5,
    nkpLN                       = 0.17,
    nlayers                     = 10,
    nlnb0                       = -5,
    nlnb1                       = 18,
    nRdb0                       = -4.5917,
    nRdb1                       = 0.1247,
    nvmaxb0                     = -16.25,
    nvmaxb1                     = 0.6938,
    par_energy_content          = 0.235,
    par_energy_fraction         = 0.5,
    phi1                        = 0.01,
    phi2                        = 1.5, 
    phi_waterstress_induced_leafsenescence = 124.31,
    remobilization_fraction     = 0.6,
    remobilization_fraction_leaf_to_rhizome = .5,
    remobilization_fraction_stem_to_rhizome = .5,
    remobilization_fraction_root_to_rhizome = .5,
    remobilization_fraction_rhizome_to_rhizome = .5,
    retrans                     = 0.9,
    retrans_rhizome             = 1.0,
    rfl                         = 0.2,
    rhizome_turnover_rate       = 0,
    RL_at_25                    = 0.8,
    root_turnover_rate          = 0,
    rsdf                        = 0.44,
    rsec                        = 0.2,
    sene_factor_when_sws_eq_0   = 1,
    sene_factor_when_sws_eq_1   = 0,
    seneLeaf                    = 3000,
    seneRhizome                 = 4000,
    seneRoot                    = 4000,
    seneStem                    = 3500,
    soil_air_entry              = -2.6,
    soil_b_coefficient          = 5.2,
    soil_bulk_density           = 1.35,
    soil_clay_content           = 0.34,
    soil_clod_size              = 0.04,
    soil_depth1                 = 0.0,
    soil_depth2                 = 1,
    soil_depth3                 = 2, 
    soil_field_capacity         = 0.32,
    soil_reflectance            = 0.2,
    soil_sand_content           = 0.32,
    soil_saturated_conductivity = 6.4e-05,
    soil_saturation_capacity    = 0.52,
    soil_silt_content           = 0.34,
    soil_transmission           = 0.01,
    soil_wilting_point          = 0.2,
    sowing_fractional_doy       = 0,
    Sp_thermal_time_decay       = 0.00038, 
    specific_heat_of_air        = 1010,
    stem_turnover_rate          = 0,
    tbase                       = 10, 
    Tfrostlow                   = -2,
    Tfrosthigh                  = 0,
    theta                       = 0.83,
    timestep                    = 1,
    time_zone_offset            = -6,
    tmax                        = 40,
    topt_lower                  = 28,
    topt_upper                  = 31,
    tp1                         = 562,
    tp2                         = 1312,
    tp3                         = 2063,
    tp4                         = 2676,
    TTc_leafsenescence_threshold = 0,
    TTc_stemsenescence_threshold = 0,
    TTc_rootsenescence_threshold = 0,
    TTc_rhizomesenescence_threshold = 0,
    TTemr                       = 400,
    TTveg                       = 1500,
    TTrep                       = 2500,
    tp5                         = 3211,
    upperT                      = 37.5,
    Vcmax_at_25                 = 39,
    windspeed_height            = 10, # for SURFRAD
    wsFun                       = 2
  )
)

parameters_to_optimize <- c("kRhizome_emr","kLeaf_emr","kStem_emr",
                            "alphaStem","betaStem","alphaLeaf","betaLeaf","alphaRoot", "betaRoot")

#this one is for turning OFF cwrf soil water
x=c(-0.000362,    0.269631,    0.609721,
    29.939436,  -39.155449,    0.199284,  -36.468715,    2.891147,   -5.831675)

miscanthus_x_giganteus$parameters[parameters_to_optimize] = x

weather_all<-read.csv(
  "../data/weather_data_NASA_POWER/BioCro_input_NASA/site_2_2002_2018_LowerTransmittance.csv")
result = list()
years = 2006:2008
for (i in 1:length(years)){
  year_i = years[i]
  growing_season_weather = weather_all[weather_all$year == year_i,]
  growing_season_weather =  growing_season_weather[growing_season_weather$doy>=106 &
                                                     growing_season_weather$doy<=350,]
  
  result[[i]] <-with(miscanthus_x_giganteus, {run_biocro(
    initial_values,
    parameters,
    drivers = growing_season_weather,
    direct_modules,
    differential_modules,
    ode_solver
  )})
}  
##########################################################################################
# Correcting for winter loss of atem based on 0.07 tons/ha per day
non_frost_weather <- get_growing_season_climate(growing_season_weather, threshold_temperature = 0)

for ( j in dim(non_frost_weather)[1]: (dim(growing_season_weather)[1])){
  result[[i]]$Stem[j] = result[[i]]$Stem[j] - (0.07/24)*(j- dim(non_frost_weather)[1])
}
########################################################################################

source("plot_single_site.R")
#avg of 2006-2008
predicted = 0
for (i in 1:length(years)){
  predicted = predicted+result[[i]][,c("doy","Stem","Leaf","Rhizome","Root")]
}
predicted = predicted/length(years)
predicted = reshape2::melt(predicted,id.vars = c("doy"),measure.vars = c("Leaf","Stem","Root","Rhizome"))

observed_biomass <- read.csv("../data/biomass_observation/il_observation_without_index.csv")

names(observed_biomass)  = c("doy", "Rhizome",     "Leaf"     ,"Stem", "Root")
observed_biomass$Root[1] = 0 # First data point of root should be zero. Observation does not make difference between alive and dead roots
observed = observed_biomass[, c("doy","Stem","Leaf","Rhizome","Root")]
observed = reshape2::melt(observed,id.vars = c("doy"),measure.vars = c("Leaf","Stem","Root","Rhizome"))
names(observed)  = c("x","varname","y")
names(predicted) = c("x","varname","y")
xlabtitle = expression(paste("Day of Year"))
ylabtitle = expression(paste("Dry Biomass (Mg/ha)"))
BiomassPartitioning <- 
  Compare_Observed_and_Predicted(observeddata = observed,predicteddata=predicted  ,xlabtitle,ylabtitle)
plot(BiomassPartitioning)
# ggsave(filename="./BiomassPartitioning.png",dpi = 500, width =6.5, height =4.2)

doy = result[[1]]$doy

