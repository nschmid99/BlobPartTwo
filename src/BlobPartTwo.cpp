#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/video/tracking.hpp>

#include "cinder/app/App.h"
#include "cinder/app/RendererGl.h"
#include "cinder/gl/gl.h"

#include "CinderOpenCV.h"

using namespace ci;
using namespace ci::app;
using namespace std;

class BlobPartTwo : public App {
  public:
	void setup() override;
	void mouseDown( MouseEvent event ) override;
	void update() override;
	void draw() override;
};

void BlobPartTwo::setup()
{
}

void BlobPartTwo::mouseDown( MouseEvent event )
{
}

void BlobPartTwo::update()
{
}

void BlobPartTwo::draw()
{
	gl::clear( Color( 0, 0, 0 ) ); 
}

CINDER_APP( BlobPartTwo, RendererGl )
