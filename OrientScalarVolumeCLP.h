#define PARSE_ARGS \
std::string inputVolume1; \
std::string outputVolume; \
std::string orientation = "LPS"; \
inputVolume1 = std::string(argv[1]); \
outputVolume = std::string(argv[2]); \
orientation = std::string(argv[3]);
