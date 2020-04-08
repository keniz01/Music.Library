/**
 * Get search results from api service.
 * @param {string} query The user supplied search query.
 */
export default (function Helpers() {

    const fetchSearchData = async (searchQuery: string, pageNumber: number, itemsPerPage: number) =>
        await fetch(`http://localhost/music.library.api/api/search/${searchQuery}/${pageNumber}/${itemsPerPage}`)
        .then(response => response.json())
        .then(data => data);

    const fetchInitialLoadData = async () =>
         await fetch(`http://localhost/music.library.api/api/home/`)
            .then(response => response.json())
            .then(data => data);

    return {
        fetchSearchData: fetchSearchData,
        fetchInitialLoadData: fetchInitialLoadData
    }
})();