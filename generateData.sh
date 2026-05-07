python generate_data.py

if [ -e "signal.bin" ]; then
	cp signal.bin MatchedFiltering/src/
    cp signal.bin MatchedFilteringTiled/src/
    cp signal.bin MatchedFilteringTiledCoarsened/src/
    rm signal.bin
fi
if [ -e "filter.bin" ]; then
	cp filter.bin MatchedFiltering/src/
    cp filter.bin MatchedFilteringTiled/src/
    cp filter.bin MatchedFilteringTiledCoarsened/src/
    rm filter.bin
fi

echo "Data generated and placed in the appropriate folders"