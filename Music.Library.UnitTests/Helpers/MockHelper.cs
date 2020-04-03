using MediatR;
using Moq;
using Music.Library.Core.Features.Home;
using Music.Library.Core.Features.Search;

namespace Music.Library.UnitTests.Helpers
{
    public static class MockHelper
    {
        public static Mock<IMediator> CreateSearchMediator(GetAlbumsResponse response)
        {
            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<GetAlbumsRequest>(), default))
                .ReturnsAsync(response);

            return fakeMediator;
        }

        public static Mock<IMediator> CreateDashboardMediator(GetDashboardResponse response)
        {
            var fakeMediator = new Mock<IMediator>(MockBehavior.Strict);
            fakeMediator.Setup(mediator => mediator.Send(It.IsAny<GetDashboardRequest>(), default))
                .ReturnsAsync(response);

            return fakeMediator;
        }
    }
}
