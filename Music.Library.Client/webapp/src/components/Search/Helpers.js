/**
 * Get search results from api service.
 * @param {string} query The user supplied search query.
 */
export default (function Helpers() {

    const fetchSearchData = async (query) =>
        await fetch(`http://localhost/music.library.api/api/search/${query}/1/100`)
        .then(rawData => rawData.json())
        .then(result => result.albums);

    const fetchInitialLoadData = async () =>
         await fetch(`http://localhost/music.library.api/api/home/`)
            .then(response => response.json())
            .then(data => data);

    return {
        fetchSearchData: fetchSearchData,
        fetchInitialLoadData: fetchInitialLoadData
    }
})();